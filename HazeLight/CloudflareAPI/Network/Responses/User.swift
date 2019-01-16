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
}

extension User: RawResponseDecodable {
    init(_ rawValue: RawUser) throws {
        id = rawValue.id
    }
}

struct RawUser: Decodable {
    let id: String
}

extension User {
    struct Request {
        typealias Response = User
        
        func router() throws -> RequestRouter {
            return Router.user
        }
    }
}

extension User {
    struct Edit: RawRequestEncodable {
        typealias Response = User
        
        let zipCode: String
        
        func asRequest() throws -> Raw {
            return Raw(zipcode: zipCode)
        }
        
        func router() throws -> RequestRouter { return Router.editUser }
    }
}

extension User.Edit {
    struct Raw: Encodable {
        let zipcode: String
    }
}

extension User {
    // TODO: Need to define how we make requests with non-Encodable Parameters.
    struct Validate: Requestable {
        typealias Response = User
        
        let email: String
        let token: String
        
        func router() throws -> RequestRouter {
            return Router.user
        }
        
        func headers() throws -> HTTPHeaders {
            return [.xAuthEmail(email),
                    .xAuthKey(token)]
        }
    }
}
