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
    init(_ rawValue: Raw) throws {
        id = rawValue.id
    }
    
    struct Raw: Decodable {
        let id: String
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
        typealias Response = User

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
}
