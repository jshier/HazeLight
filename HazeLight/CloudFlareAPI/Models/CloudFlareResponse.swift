//
//  CloudFlareResponse.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Argo
import Curry
import Runes

struct CloudFlareResponse {
    let result: JSON
    let isSuccess: Bool
    let errors: [CloudFlareResponseError]
    let messages: [JSON]
}

extension CloudFlareResponse: Decodable {
    static func decode(_ json: JSON) -> Decoded<CloudFlareResponse> {
        let cinit = curry(self.init)
        
        return cinit
            <^> json <| "result"
            <*> json <| "success"
            <*> json <|| "errors"
            <*> json <|| "messages"
    }
}
