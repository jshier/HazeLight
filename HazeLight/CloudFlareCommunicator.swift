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
        return Alamofire.request(CloudFlareRouter.User).responseObject { (responseObject: CloudFlareUser?, error) in
            switch (responseObject, error) {
            case (.Some, .None):
                print("Successful.")
            case (.None, .Some):
                print("Failed.")
            default:
                print("Unknown.")
            }
        }
    }
}
