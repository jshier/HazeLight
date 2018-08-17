//
//  BaseResponseSerializer.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire

final class BaseResponseSerializer<Value: RawDecodable>: DataResponseSerializerProtocol {
    func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> BaseResponse<Value> {
        guard error == nil else { throw error! }
        
        guard let data = data else {
            throw ResponseError.noData
        }
        
        let rawBaseResponse = try JSONDecoder.cloudflare.decode(RawBaseResponse<Value>.self, from: data)
        return try BaseResponse<Value>(rawBaseResponse)
    }
}

enum ResponseError: Error {
    case noData
}

extension JSONDecoder {
    static let cloudflare: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }()
}
