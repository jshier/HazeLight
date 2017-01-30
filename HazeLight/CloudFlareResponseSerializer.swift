//
//  CloudFlareResponseSerializer.swift
//  HazeLight
//
//  Created by Jon Shier on 1/29/17.
//  Copyright © 2017 Jon Shier. All rights reserved.
//

import Alamofire
import Argo
import Foundation

struct CloudFlareResponseSerializer<T: Decodable>: DataResponseSerializerProtocol where T == T.DecodedType {
    
    var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<T> = { (request, response, data, error) in
        guard error == nil else { return .failure(CloudFlareError.network(error: error!)) }
        
        let jsonSerializationResult = DataRequest.jsonResponseSerializer().serializeResponse(request, response, data, nil)
        guard case let .success(responseJSON) = jsonSerializationResult else {
            return .failure(CloudFlareError.serialization(error: jsonSerializationResult.error!))
        }
        
        let decodedCloudFlareResponse = CloudFlareResponse.decode(JSON(responseJSON))
        guard case let .success(cloudFlareResponse) = decodedCloudFlareResponse else {
            return .failure(CloudFlareError.decoding(error: decodedCloudFlareResponse.error!))
        }
        
        guard cloudFlareResponse.isSuccess else { return .failure(CloudFlareError.response(response: cloudFlareResponse)) }
        
        let decodedResponseValue = T.decode(cloudFlareResponse.result)
        guard case let .success(responseValue) = decodedResponseValue else {
            return .failure(CloudFlareError.decoding(error: decodedResponseValue.error!))
        }
        
        return .success(responseValue)
    }
    
}

//    func log<T: Decodable where T == T.DecodedType>(_ request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, result: Result<T, CloudFlareError>) {
//        var printStream = ""
//        print("*** START RESPONSE LOG ***\n", toStream: &printStream)
//
//        print("\(self)\n", toStream: &printStream)
//
//        if let sessionHeaders = session.configuration.HTTPAdditionalHeaders {
//            print("Session Headers:", toStream: &printStream)
//            print(stringFromHeaders(sessionHeaders), toStream: &printStream)
//        }
//        else {
//            print("No session headers.\n", toStream: &printStream)
//        }
//
//        if let requestHeaders = request?.allHTTPHeaderFields {
//            print("Request Headers:", toStream: &printStream)
//            print(stringFromHeaders(requestHeaders), toStream: &printStream)
//        }
//        else {
//            print("No request headers.\n", toStream: &printStream)
//        }
//
//        if let requestBody = request?.HTTPBody,
//            bodyString = NSString(data: requestBody, encoding: NSUTF8StringEncoding) {
//            print("Request Body:", toStream: &printStream)
//            print(bodyString, toStream: &printStream)
//        }
//        else {
//            print("No request body.\n", toStream: &printStream)
//        }
//
//        if let responseHeaders = response?.allHeaderFields {
//            print("Response Headers:", toStream: &printStream)
//            print(stringFromHeaders(responseHeaders), toStream: &printStream)
//        }
//        else {
//            print("No response headers.\n", toStream: &printStream)
//        }
//
//        let stringSerializer = Request.stringResponseSerializer()
//        let stringResult = stringSerializer.serializeResponse(request, response, data, nil)
//        switch stringResult {
//        case let .Success(string):
//            print("Response String:", toStream: &printStream)
//            print("\(string)\n", toStream: &printStream)
//        case let .Failure(error):
//            print("Could not deserialize response as string due to error:", toStream: &printStream)
//            print("\(error)\n", toStream: &printStream)
//        }
//
//        let JSONSerializer = Request.JSONResponseSerializer()
//        let JSONResult = JSONSerializer.serializeResponse(request, response, data, nil)
//        switch JSONResult {
//        case let .Success(responseJSON):
//            print("Response JSON:", toStream: &printStream)
//            print("\(responseJSON)\n", toStream: &printStream)
//        case let .Failure(error):
//            print("Could not deserialize response as JSON due to error:", toStream: &printStream)
//            print("\(error)", toStream: &printStream)
//        }
//
//        switch result {
//        case let .Success(object):
//            print("Response Object:", toStream: &printStream)
//            print("\(object)\n", toStream: &printStream)
//        case let .Failure(error):
//            print("Could not deserialize response object due to error:", toStream: &printStream)
//            print("\(error)", toStream: &printStream)
//        }
//
//        debugPrint(self, toStream: &printStream)
//
//        print("\n*** END RESPONSE LOG ***", toStream: &printStream)
//
//        print(printStream)
//    }
//
//    func stringFromHeaders(_ headers: [AnyHashable: Any]) -> String {
//        var printStream = ""
//
//        let sortedKeys = headers.keys.sort { $0.description.caseInsensitiveCompare($1.description) == .OrderedAscending }
//        sortedKeys.forEach { print("\t\($0) : \(headers[$0]!)", toStream: &printStream) }
//
//        return printStream
//    }
