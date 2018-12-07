//
//  BaseResponse.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

struct BaseResponse<Value: RawResponseDecodable> {
    struct Error: Decodable {
        let code: Int
        let message: String
    }
    struct Info {
        let page: Int
        let perPage: Int
        let count: Int
        let totalCount: Int
    }
    
    let value: Value?
    let info: Info?
    let isSuccess: Bool
    let errors: [Error]
    let messages: [String]
}

extension BaseResponse: RawResponseDecodable {
    init(_ rawValue: RawBaseResponse<Value>) throws {
        value = try rawValue.result.map { try Value($0) }
        info = try rawValue.result_info.map { try Info($0) }
        isSuccess = rawValue.success
        errors = rawValue.errors
        messages = rawValue.messages
    }
}

extension BaseResponse.Info: RawResponseDecodable {
    init(_ rawValue: RawBaseResponse<Value>.RawInfo) throws {
        page = rawValue.page
        perPage = rawValue.per_page
        count = rawValue.count
        totalCount = rawValue.total_count
    }
}

struct RawBaseResponse<Value: RawResponseDecodable>: Decodable {
    struct RawInfo: Decodable {
        let page: Int
        let per_page: Int
        let count: Int
        let total_count: Int
    }
    
    let result: Value.RawResponse?
    let result_info: RawInfo?
    let success: Bool
    let messages: [String]
    let errors: [BaseResponse<Value>.Error]
}
