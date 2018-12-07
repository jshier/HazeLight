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
    
    typealias Completion<Request: Requestable> = (_ response: DataResponse<BaseResponse<Request.Response>>) -> Void
    
    func fetchUser(_ completion: @escaping Completion<User.Request>) {
        perform(User.Request(), completion: completion)
    }
    
    func editUser(_ user: User.Edit, completion: @escaping Completion<User.Edit>) {
        
    }
    
//    func editUser(_ user: User.Edit, completion: @escaping)
    
    func perform<Request: Requestable>(_ request: Request, completion: @escaping Completion<Request>) {
        session.request(request).responseValue(handler: completion)
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
    
    func adapt(_ urlRequest: URLRequest, completion: @escaping (Result<URLRequest>) -> Void) {
        completion(Result {
            var urlRequest = urlRequest
            
            let credential = try (users().pendingCredential.value ?? users().currentCredential.value).unwrapped().unwrapped()
            urlRequest.httpHeaders.add(name: "X-Auth-Email", value: credential.email)
            urlRequest.httpHeaders.add(name: "X-Auth-Key", value: credential.token)
            
            return urlRequest
        })
    }
}

final class LoggingMonitor: EventMonitor {
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value>) {
        debugPrint(response)
        let body = request.data.flatMap { String(data: $0, encoding: .utf8) } ?? "No body."
        print("[Body]: \(body)")
    }
}
