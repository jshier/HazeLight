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
        return Alamofire.request(CloudFlareRouter.User).responseObject { (result: Result<CloudFlareUser, CloudFlareError>) in
            print(result)
        }
    }
}
