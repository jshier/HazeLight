//
//  CloudFlareResponse.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Argo
import Curry

struct CloudFlareResponse {
    let result: JSON
    let success: Bool
    let errors: [CloudFlareResponseError]
    let messages: [JSON]
}

extension CloudFlareResponse : Decodable {
    static func decode(json: JSON) -> Decoded<CloudFlareResponse> {
        return curry(self.init)
            <^> json <| "result"
            <*> json <| "success"
            <*> json <|| "errors"
            <*> json <|| "messages"
    }
}
