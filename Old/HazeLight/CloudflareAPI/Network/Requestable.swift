//
//  Requestable.swift
//  HazeLight
//
//  Created by Jon Shier on 9/6/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire
import Foundation
//
//protocol Requestable: URLRequestConvertible {
//    associatedtype Parameters: Encodable
//    
//    var route: Router { get }
//    var parameters: Parameters? { get }
//}
//
//extension Requestable {
//    var parameters: None? { return nil }
//}
//
//struct None: Encodable { }
//
//extension Requestable {
//    func asURLRequest() throws -> URLRequest {
//        let url = route.baseURL.appendingPathComponent(route.path)
//        let request = try URLRequest(url: url, method: route.httpMethod)
//        
//        return try route.parameterEncoder?.encode(parameters, into: request) ?? request
//    }
//}
