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
        let fullCompletionHandler = { (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, result: Result<T, CloudFlareError>) in
            self.log(request, response: response, data: data, result: result)
            dispatchMain { completionHandler(responseObject: result.value, error: result.error) }
        }
        
        return response(queue: Request.responseQueue, responseSerializer: Request.CloudFlareResponseSerializer(), completionHandler: fullCompletionHandler)
    }
    
    static func CloudFlareResponseSerializer<T: Decodable where T == T.DecodedType>() -> GenericResponseSerializer<T, CloudFlareError> {
        return GenericResponseSerializer { (request, response, data, error) in
            guard error == nil else {
                return .Failure(CloudFlareError.NetworkError(error: error!))
            }
            
            guard let validData = data else {
                let failureReason = "Tried to decode response with nil data."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(CloudFlareError.SerializationError(error: error))
            }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let JSONResult = JSONSerializer.serializeResponse(request, response, validData, nil)
            guard case let .Success(responseJSON) = JSONResult else {
                return .Failure(CloudFlareError.SerializationError(error: JSONResult.error!))
            }
            
            let decodedCloudFlareResponse = CloudFlareResponse.decode(JSON.parse(responseJSON))
            guard case let .Success(cloudFlareResponse) = decodedCloudFlareResponse else {
                var errorString = "Unknown error."
                if case let .Failure(decodeError) = decodedCloudFlareResponse {
                    errorString = decodeError.description
                }
                
                return .Failure(CloudFlareError.DecodingError(decodedString: errorString))
            }
            
            guard cloudFlareResponse.success else {
                return .Failure(CloudFlareError.ResponseError(response: cloudFlareResponse))
            }
            
            let decodedResponseObject = T.decode(cloudFlareResponse.result)
            guard case let .Success(responseObject) = decodedResponseObject else {
                var errorString = "Unknown error."
                if case let .Failure(decodeError) = decodedResponseObject {
                    errorString = decodeError.description
                }
                
                return .Failure(CloudFlareError.DecodingError(decodedString: errorString))
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
