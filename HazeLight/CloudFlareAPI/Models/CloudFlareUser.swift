//
//  CloudFlareUser.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Argo
import Curry

struct CloudFlareUser {
    let ID: String
    let email: String
    let firstName: String?
    let lastName: String?
    let username: String
    let phoneNumber: String?
    let country: String?
    let zipCode: String?
    let creationDate: String
    let lastModifiedDate: String
    let isTwoFactorAuthenticationEnabled: Bool
    let isTwoFactorAuthenticationLocked: Bool
    let hasProZones: Bool
    let hasBusinessZones: Bool
    let hasEnterpriseZones: Bool
}

extension CloudFlareUser : Decodable {
    static func decode(json: JSON) -> Decoded<CloudFlareUser> {
        let part1 = curry(self.init)
            <^> json <| "id"
            <*> json <| "email"
            <*> json <|? "first_name"
            <*> json <|? "last_name"
            <*> json <| "username"
            <*> json <|? "telephone"
            <*> json <|? "country"
            
        return part1
            <*> json <|? "zipcode"
            <*> json <| "created_on"
            <*> json <| "modified_on"
            <*> json <| "two_factor_authentication_enabled"
            <*> json <| "two_factor_authentication_locked"
            <*> json <| "has_pro_zones"
            <*> json <| "has_business_zones"
            <*> json <| "has_enterprise_zones"
    }
}