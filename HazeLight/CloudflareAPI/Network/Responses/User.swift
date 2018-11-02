//
//  User.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

struct User {
    let id: String
}

extension User: RawDecodable {
    init(_ rawValue: RawUser) throws {
        id = rawValue.id
    }
}

extension User {
    struct Request { }
}

extension User.Request: Requestable {    
    var route: Router { return .user }
}

struct RawUser: Decodable {
    let id: String
}

extension User {
    struct Get { }
}

extension User.Get: Requestable {
    var route: Router { return .user }
}
