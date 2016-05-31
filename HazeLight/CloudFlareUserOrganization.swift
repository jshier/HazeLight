//
//  CloudFlareUserOrganization.swift
//  HazeLight
//
//  Created by Jon Shier on 5/29/16.
//  Copyright © 2016 Jon Shier. All rights reserved.
//

import Argo
import Curry

struct CloudFlareUserOrganization {
    let ID: String
    let name: String
    let status: CloudFlareUserOrganizationStatus
    let permissions: [String]
    let roles: [String]
}

extension CloudFlareUserOrganization: Decodable {
    static func decode(json: JSON) -> Decoded<CloudFlareUserOrganization> {
        let cinit = curry(self.init)
        
        return cinit
            <^> json <| "id"
            <*> json <| "name"
            <*> json <| "status"
            <*> json <|| "permissions"
            <*> json <|| "roles"
    }
}

enum CloudFlareUserOrganizationStatus: String {
    case Member = "member"
    case Invited = "invited"
}

extension CloudFlareUserOrganizationStatus: Decodable { }