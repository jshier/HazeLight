//
//  Router.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire
import Foundation

enum Router {
    case user
    
    var baseURL: URL {
        return URL(string: "https://api.cloudflare.com/client/v4/")!
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameterEncoder: ParameterEncoder? {
        return nil
    }
    
    var path: String {
        return "user"
    }
}
