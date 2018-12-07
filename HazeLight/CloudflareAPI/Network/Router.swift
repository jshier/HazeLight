//
//  Router.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire
import Foundation

enum Router: RequestRouter {
    case user
    case editUser
    
    var baseURL: URL {
        return URL(string: "https://api.cloudflare.com/client/v4/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .user: return .get
        case .editUser: return .patch
        }
    }
    
    var path: String {
        return "user"
    }
    
    var parameterEncoder: ParameterEncoder {
        return JSONParameterEncoder()
    }
    
    var responseDecoder: ResponseDecoder {
        return JSONDecoder()
    }
}
