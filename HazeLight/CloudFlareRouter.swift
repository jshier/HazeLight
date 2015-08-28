//
//  CloudFlareRouter.swift
//  HazeLight
//
//  Created by Jon Shier on 6/20/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Foundation
import Alamofire
import Keys

enum CloudFlareRouter : URLRequestConvertible {
    static let baseURLString = "https://api.cloudflare.com/client/v4/"
    static let token = HazelightKeys().cloudFlareAPIKey()
    
    case User

    var method: Alamofire.Method {
        switch self {
        case User:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case User:
            return "user"
        }
    }
    
    var headers: [String : String] {
        // TODO: Pull current user / token from keychain.
        return ["X-Auth-Key" : CloudFlareRouter.token,
                "X-Auth-Email" : "jon@jonshier.com"]
    }
    
    var parameters: [String : String]? {
        switch self {
        case User:
            return .None
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: CloudFlareRouter.baseURLString)!
        let request = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        request.HTTPMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return ParameterEncoding.URL.encode(request, parameters: parameters).0
    }
}
