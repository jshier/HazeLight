//
//  Extensions.swift
//  HazeLight
//
//  Created by Jon Shier on 4/11/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

extension Result {
    var value: Success? {
        switch self {
        case let .success(value): return value
        case .failure: return nil
        }
    }
    
    var error: Failure? {
        switch self {
        case .success: return nil
        case let .failure(error): return error
        }
    }
}
