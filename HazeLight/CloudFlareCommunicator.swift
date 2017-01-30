//
//  CloudFlareCommunicator.swift
//  HazeLight
//
//  Created by Jon Shier on 6/21/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Foundation
import Alamofire
import Argo

class CloudFlareCommunicator {
    @discardableResult
    static func fetchCurrentUser() -> DataRequest {
        return Alamofire.request(CloudFlareRouter.user).responseValue { (response: DataResponse<CloudFlareUser>) in
            print(response)
        }
    }
}

extension DataRequest {
    static let responseQueue = DispatchQueue(label: "com.jonshier.HazeLight.responseQueue", qos: .default, attributes: .concurrent)
    
    func responseValue<T: Decodable>(_ completionHandler: @escaping (_ response: DataResponse<T>) -> Void) -> Self where T == T.DecodedType {
        //        let fullCompletionHandler = { (response: Response<T, CloudFlareError>) in
        //            self.log(response.request, response: response.response, data: response.data, result: response.result)
        //            dispatchMain { completionHandler(result: response.result) }
        //        }
        
        return response(queue: DataRequest.responseQueue, responseSerializer: CloudFlareResponseSerializer(), completionHandler: completionHandler)
    }
}
