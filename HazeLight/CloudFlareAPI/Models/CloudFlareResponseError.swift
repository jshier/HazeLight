//
//  CloudFlareResponseError.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Argo
import Curry

struct CloudFlareResponseError {
    let code: Int
    let message: String
}

extension CloudFlareResponseError : Decodable {
    static func decode(json: JSON) -> Decoded<CloudFlareResponseError> {
        return curry(self.init)
            <^> json <| "code"
            <*> json <| "message"
    }
}