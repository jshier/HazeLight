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


    static let baseURL = URL(string: "https://api.cloudflare.com/client/v4/")!
    static let token = HazeLightKeys().cloudFlareAPIKey
    
    case user

    var method: Alamofire.HTTPMethod {
        switch self {
        case .user:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .user:
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
        case .user:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .user:
            return URLEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: CloudFlareRouter.baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return try parameterEncoding.encode(request, with: parameters)
    }
}
