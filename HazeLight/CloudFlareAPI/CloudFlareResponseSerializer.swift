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
    func responseObject<T: Decodable where T == T.DecodedType>(completionHandler: (responseObject: T?, error: CloudFlareError?) -> Void) -> Self {
        let fullCompletionHandler = { (request: NSURLRequest?, response: NSURLResponse?, result: Result<T>) in
            switch result {
            case let .Success(value):
                completionHandler(responseObject: value, error: .None)
            case let .Failure(_, error):
                if let error = error as? CloudFlareError {
                    completionHandler(responseObject: .None, error: error)
                }
                else if let error = error as? NSError {
                    // Must have received a network error.
                    completionHandler(responseObject: .None, error: CloudFlareError.NetworkError(error: error))
                }
                else {
                    fatalError("ResponseObject received an error that was neither a CloudFlareError nor an NSError.")
                }
            }
        }
        return response(responseSerializer: Request.CloudFlareResponseSerializer(), completionHandler: fullCompletionHandler)
    }
    
    static func CloudFlareResponseSerializer<T: Decodable where T == T.DecodedType>() -> GenericResponseSerializer<T> {
        return GenericResponseSerializer { (request, response, data) -> Result<T> in
            guard let validData = data else {
                let failureReason = "Tried to decode response with nil data."
                let error = Error.errorWithCode(.DataSerializationFailed, failureReason: failureReason)
                return .Failure(data, CloudFlareError.SerializationError(error: error))
            }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let JSONResult = JSONSerializer.serializeResponse(request, response, validData)
            guard case let .Success(responseJSON) = JSONResult else {
                return .Failure(data, CloudFlareError.SerializationError(error: JSONResult.error! as NSError))
            }
            
            let decodedCloudFlareResponse = CloudFlareResponse.decode(JSON.parse(responseJSON))
            guard case let .Success(cloudFlareResponse) = decodedCloudFlareResponse else {
                let errorString: String
                switch decodedCloudFlareResponse {
                case let .TypeMismatch(error):
                    errorString = error
                case let .MissingKey(error):
                    errorString = error
                default:
                    errorString = "Should never see this."
                }
                
                return .Failure(data, CloudFlareError.DecodingError(decodedString: errorString))
            }
            
            if !cloudFlareResponse.success {
                return .Failure(data, CloudFlareError.ResponseError(response: cloudFlareResponse))
            }
            
            let decodedResponseObject = T.decode(cloudFlareResponse.result)
            guard case let .Success(responseObject) = decodedResponseObject else {
                let errorString: String
                switch decodedResponseObject {
                case let .TypeMismatch(error):
                    errorString = error
                case let .MissingKey(error):
                    errorString = error
                default:
                    errorString = "Should never see this."
                }
                
                return .Failure(data, CloudFlareError.DecodingError(decodedString: errorString))
            }
            
            return .Success(responseObject)
        }
    }
}
