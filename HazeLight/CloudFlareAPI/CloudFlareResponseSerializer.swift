//
//  CloudFlareResponseSerializer.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Alamofire
import Argo

extension Request {
    static let responseQueue = dispatch_queue_create("com.jonshier.hazelight.responseQueue", DISPATCH_QUEUE_CONCURRENT)
    
    func responseObject<T: Decodable where T == T.DecodedType>(completionHandler: (responseObject: T?, error: CloudFlareError?) -> Void) -> Self {
        let fullCompletionHandler = { (response: Response<T, CloudFlareError>) in
            self.log(response.request, response: response.response, data: response.data, result: response.result)
            dispatchMain { completionHandler(responseObject: response.result.value, error: response.result.error) }
        }
        
        return response(queue: Request.responseQueue, responseSerializer: Request.CloudFlareResponseSerializer(), completionHandler: fullCompletionHandler)
    }
    
    static func CloudFlareResponseSerializer<T: Decodable where T == T.DecodedType>() -> ResponseSerializer<T, CloudFlareError> {
        return ResponseSerializer { (request, response, data, error) in
            guard error == nil else {
                return .Failure(CloudFlareError.NetworkError(error: error!))
            }

            let JSONResult = Request.JSONResponseSerializer().serializeResponse(request, response, data, nil)
            guard case let .Success(responseJSON) = JSONResult else {
                return .Failure(CloudFlareError.SerializationError(error: JSONResult.error!))
            }
            
            let decodedCloudFlareResponse = CloudFlareResponse.decode(JSON.parse(responseJSON))
            guard case let .Success(cloudFlareResponse) = decodedCloudFlareResponse else {
                return .Failure(CloudFlareError.DecodingError(decodedString: decodedCloudFlareResponse.error!.description))
            }
            
            guard cloudFlareResponse.success else {
                return .Failure(CloudFlareError.ResponseError(response: cloudFlareResponse))
            }
            
            let decodedResponseObject = T.decode(cloudFlareResponse.result)
            guard case let .Success(responseObject) = decodedResponseObject else {
                return .Failure(CloudFlareError.DecodingError(decodedString: decodedResponseObject.error!.description))
            }
            
            return .Success(responseObject)
        }
    }
    
    func log<T: Decodable where T == T.DecodedType>(request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, result: Result<T, CloudFlareError>) {
        var printStream = ""
        print("*** START RESPONSE LOG ***\n", toStream: &printStream)
        
        print("\(self)\n", toStream: &printStream)
        
        if let sessionHeaders = session.configuration.HTTPAdditionalHeaders {
            print("Session Headers:", toStream: &printStream)
            print(stringFromHeaders(sessionHeaders), toStream: &printStream)
        }
        else {
            print("No session headers.\n", toStream: &printStream)
        }
        
        if let requestHeaders = request?.allHTTPHeaderFields {
            print("Request Headers:", toStream: &printStream)
            print(stringFromHeaders(requestHeaders), toStream: &printStream)
        }
        else {
            print("No request headers.\n", toStream: &printStream)
        }
        
        if let requestBody = request?.HTTPBody,
            bodyString = NSString(data: requestBody, encoding: NSUTF8StringEncoding) {
            print("Request Body:", toStream: &printStream)
            print(bodyString, toStream: &printStream)
        }
        else {
            print("No request body.\n", toStream: &printStream)
        }
        
        if let responseHeaders = response?.allHeaderFields {
            print("Response Headers:", toStream: &printStream)
            print(stringFromHeaders(responseHeaders), toStream: &printStream)
        }
        else {
            print("No response headers.\n", toStream: &printStream)
        }
        
        let stringSerializer = Request.stringResponseSerializer()
        let stringResult = stringSerializer.serializeResponse(request, response, data, nil)
        switch stringResult {
        case let .Success(string):
            print("Response String:", toStream: &printStream)
            print("\(string)\n", toStream: &printStream)
        case let .Failure(error):
            print("Could not deserialize response as string due to error:", toStream: &printStream)
            print("\(error)\n", toStream: &printStream)
        }
        
        let JSONSerializer = Request.JSONResponseSerializer()
        let JSONResult = JSONSerializer.serializeResponse(request, response, data, nil)
        switch JSONResult {
        case let .Success(responseJSON):
            print("Response JSON:", toStream: &printStream)
            print("\(responseJSON)\n", toStream: &printStream)
        case let .Failure(error):
            print("Could not deserialize response as JSON due to error:", toStream: &printStream)
            print("\(error)", toStream: &printStream)
        }
        
        switch result {
        case let .Success(object):
            print("Response Object:", toStream: &printStream)
            print("\(object)\n", toStream: &printStream)
        case let .Failure(error):
            print("Could not deserialize response object due to error:", toStream: &printStream)
            print("\(error)", toStream: &printStream)
        }
        
        debugPrint(self, toStream: &printStream)
        
        print("\n*** END RESPONSE LOG ***", toStream: &printStream)
        
        print(printStream)
    }
    
    func stringFromHeaders(headers: [NSObject : AnyObject]) -> String {
        var printStream = ""
        
        let sortedKeys = headers.keys.sort { $0.description.caseInsensitiveCompare($1.description) == .OrderedAscending }
        sortedKeys.forEach { print("\t\($0) : \(headers[$0]!)", toStream: &printStream) }
        
        return printStream
    }
}
