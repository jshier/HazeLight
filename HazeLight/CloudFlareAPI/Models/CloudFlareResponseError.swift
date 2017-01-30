//
//  CloudFlareResponseError.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Argo
import Curry
import Runes

struct CloudFlareResponseError {
    let code: Int
    let message: String
}

extension CloudFlareResponseError: Decodable {
    static func decode(_ json: JSON) -> Decoded<CloudFlareResponseError> {
        let cinit = curry(self.init)
        return cinit
            <^> json <| "code"
            <*> json <| "message"
    }
}
