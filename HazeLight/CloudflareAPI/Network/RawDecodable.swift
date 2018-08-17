//
//  RawDecodable.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

protocol RawDecodable {
    associatedtype RawType: Decodable
    
    init(_ rawValue: RawType) throws
}

extension Optional {
    func unwrapped() throws -> Wrapped {
        guard case let .some(value) = self else {
            throw OptionalError.noExpectedValue(type: String(reflecting: Wrapped.self))
        }
        
        return value
    }
}

enum OptionalError: Error {
    case noExpectedValue(type: String)
}
