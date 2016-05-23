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
    let creationDate: NSDate
    let lastModifiedDate: NSDate
    let isTwoFactorAuthenticationEnabled: Bool
    let isTwoFactorAuthenticationLocked: Bool
    let hasProZones: Bool
    let hasBusinessZones: Bool
    let hasEnterpriseZones: Bool
}

extension CloudFlareUser : Decodable {
    static func decode(j: JSON) -> Decoded<CloudFlareUser> {
        let cinit = curry(self.init)
            
        return cinit
            <^> j <| "id"
            <*> j <| "email"
            <*> j <|? "first_name"
            <*> j <|? "last_name"
            <*> j <| "username"
            <*> j <|? "telephone"
            <*> j <|? "country"
            <*> j <|? "zipcode"
            <*> (j <| "created_on" >>- toISO8601Date)
            <*> (j <| "modified_on" >>- toISO8601Date)
            <*> j <| "two_factor_authentication_enabled"
            <*> j <| "two_factor_authentication_locked"
            <*> j <| "has_pro_zones"
            <*> j <| "has_business_zones"
            <*> j <| "has_enterprise_zones"
    }
}