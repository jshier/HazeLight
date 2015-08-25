//
//  CloudFlareError.swift
//  HazeLight
//
//  Created by Jon Shier on 8/23/15.
//  Copyright © 2015 Jon Shier. All rights reserved.
//

import Foundation
import Argo

enum CloudFlareError : ErrorType {
    case NetworkError(error: NSError)
    case SerializationError(error: NSError)
    case DecodingError(decodedString: String)
    case ResponseError(response: CloudFlareResponse)
    
    var errorDescription: String {
        switch self {
        case let .NetworkError(error):
            return error.description
        case let .SerializationError(error):
            return error.description
        case let .DecodingError(decodedString):
            return decodedString
        case let .ResponseError(response):
            let messages = response.errors.map { "\($0.message) [\($0.code)]" }
            return messages.joinWithSeparator("\n\n")
        }
    }
    
    var type: String {
        switch self {
        case .NetworkError:
            return "NetworkError"
        case .SerializationError:
            return "SerializationError"
        case .DecodingError:
            return "DecodingError"
        case .ResponseError:
            return "ResponseError"
        }
    }
}

extension CloudFlareError : CustomStringConvertible {
    var description: String {
        return "\(type): \(errorDescription)"
    }
}

extension CloudFlareError : CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(self)"
    }
}
