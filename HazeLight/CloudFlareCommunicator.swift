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
    static func fetchCurrentUser() -> Request {
        return Alamofire.request(CloudFlareRouter.User).responseJSON { (request, response, result) in
            if let request = request {
                print(request)
            }
            
            if let response = response {
                print(response)
            }
            
            debugPrint(result)
            
            if case let .Success(json) = result {
                print(CloudFlareResponse.decode(JSON.parse(json)))
            }
        }
    }
}
