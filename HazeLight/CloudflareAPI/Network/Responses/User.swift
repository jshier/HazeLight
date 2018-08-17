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

struct RawUser: Decodable {
    let id: String
}
