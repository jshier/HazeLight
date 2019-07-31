//
//  Requestable.swift
//  HazeLight
//
//  Created by Jon Shier on 9/6/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire
import Foundation

protocol Requestable2 {
    associatedtype Parameters: RawRequestEncodable
    associatedtype Response: RawResponseDecodable
    associatedtype Router: RequestRouter
    
    
    func parameters() throws -> Parameters
    func router() throws -> Router
}

protocol Resource {
    
}

protocol Parameterizable {
    
}

