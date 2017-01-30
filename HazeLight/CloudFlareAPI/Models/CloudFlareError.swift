//
//  CloudFlareError.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Foundation

enum CloudFlareError: Error {
    case network(error: Error)
    case serialization(error: Error)
    case decoding(error: Error)
    case response(response: CloudFlareResponse)
    
    var errorDescription: String {
        switch self {
        case let .network(error):
            return error.localizedDescription
        case let .serialization(error):
            return error.localizedDescription
        case let .decoding(error):
            return error.localizedDescription
        case let .response(response):
            return response.errors.map { "\($0.message) [\($0.code)]" }
                                  .joined(separator: "\n\n")
        }
    }
    
    var type: String {
        switch self {
        case .network:
            return "NetworkError"
        case .serialization:
            return "SerializationError"
        case .decoding:
            return "DecodingError"
        case .response:
            return "ResponseError"
        }
    }
}

extension CloudFlareError: CustomStringConvertible {
    var description: String {
        return "\(type): \(errorDescription)"
    }
}

extension CloudFlareError: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(self)"
    }
}
