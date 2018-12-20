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

extension User {
    struct Request { }
}

extension User.Request: Requestable, Encodable {
    typealias Response = User
    
    func router() throws -> RequestRouter {
        return Router.user
    }
}

struct RawUser: Decodable {
    let id: String
}

extension User {
    struct Edit: RawRequestEncodable {
        let zipCode: String
        
        func asRequest() throws -> User.RawEdit {
            return User.RawEdit(zipcode: zipCode)
        }
    }
}

extension User {
    struct RawEdit: Requestable, Encodable {
        typealias Response = User
        
        let zipcode: String
        
        func router() throws -> RequestRouter { return Router.editUser }
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
