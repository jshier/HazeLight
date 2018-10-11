//
//  NetworkController.swift
//  HazeLight
//
//  Created by Jon Shier on 9/20/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Alamofire
import Foundation

final class NetworkController {
    static let shared = NetworkController()
    
    let session: Session
    
    init(session: Session = .hazeLight) {
        self.session = session
    }
    
    func fetchUser(_ completion: @escaping (_ response: DataResponse<BaseResponse<User>>) -> Void) {
        session.request(User.Get()).responseValue(handler: completion)
    }
}

extension Session {
    static let hazeLight: Session = {
        let session = Session(adapter: UserCredentialAdapter(), eventMonitors: [LoggingMonitor()])
        
        return session
    }()
}

final class UserCredentialAdapter: RequestAdapter {
    // TODO: Observe UserModelController
    private let users: () -> UsersModelController
    
    init(users: @escaping @autoclosure () -> UsersModelController = .shared) {
        self.users = users
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        let credential = try (users().pendingCredential.value ?? users().currentCredential.value).unwrapped().unwrapped()
        
        urlRequest.addValue(credential.email, forHTTPHeaderField: "X-Auth-Email")
        urlRequest.addValue(credential.token, forHTTPHeaderField: "X-Auth-Key")
        
        return urlRequest
    }
}

final class LoggingMonitor: EventMonitor {
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value>) {
        debugPrint(response)
    }
}
