//
//  User.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire
import Foundation

struct User {
    let id: String
    let username: String
    let firstName: String?
    let lastName: String?
    let isTwoFactorEnabled: Bool
    let isTwoFactorLocked: Bool
}

extension User: RawResponseDecodable {
    init(_ rawValue: Raw) throws {
        id = rawValue.id
        username = rawValue.username
        firstName = rawValue.first_name
        lastName = rawValue.last_name
        isTwoFactorEnabled = rawValue.two_factor_authentication_enabled
        isTwoFactorLocked = rawValue.two_factor_authentication_locked
    }
    
    struct Raw: Decodable {
        let id: String
        let username: String
        let first_name: String?
        let last_name: String?
        let two_factor_authentication_enabled: Bool
        let two_factor_authentication_locked: Bool
    }
}

extension User: CustomStringConvertible {
    var description: String {
        return "User: \(username)"
    }
}

extension User {
    struct Request { }
}

extension User.Request: Requestable {
    typealias Response = User
    
    func router() throws -> RequestRouter {
        return Router.user
    }
}

extension User {
    struct Edit: RawRequestEncodable {
        typealias Response = User
        
        let zipCode: String
        
        func router() throws -> RequestRouter {
            return Router.editUser
        }
        
        func asRequest() throws -> User.Edit.Raw {
            return User.Edit.Raw(zipcode: zipCode)
        }
    }
}

extension User.Edit {
    struct Raw: Encodable {
        let zipcode: String
    }
}

extension User {
    struct Validate: Requestable {
        typealias Response = ValidationResponse

        let email: String
        let token: String

        func router() throws -> RequestRouter {
            return Router.user
        }
        
        func headers() throws -> HTTPHeaders? {
            return [.xAuthEmail(email),
                    .xAuthKey(token)]
        }
    }
    
    struct ValidationResponse {
        let id: String
    }
}

extension User.ValidationResponse: RawResponseDecodable {
    init(_ rawValue: RawResponse) throws {
        self.id = rawValue.id
    }
    
    struct RawResponse: Decodable {
        let id: String
    }
}
