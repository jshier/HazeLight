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
    
    let session: () -> Session
    
    init(session: @escaping @autoclosure () -> Session = .hazeLight) {
        self.session = session
    }
    
    typealias Completion<Request: Requestable> = (_ response: DataResponse<BaseResponse<Request.Response>>) -> Void
    
    func validate(email: String, token: String, completion: @escaping Completion<User.Validate>) {
        performs(User.Validate(email: email, token: token), completion: completion)
    }
    
    func fetchUser(_ completion: @escaping Completion<User.Request>) {
        performs(User.Request(), completion: completion)
    }
    
    func editUser(_ userEdit: User.Edit, completion: @escaping Completion<User.Edit>) {
        performs(userEdit, completion: completion)
    }

    func perform<Request: Requestable>(_ request: Request, completion: @escaping Completion<Request>) {
        session().request(request).responseValue(handler: completion)
    }
    
    func performs<Request: Requestable, Response>(_ request: Request, completion: @escaping Completion<Request>)
        where Response == Request.Response, Response: NetworkObservable {
        Response.loading.updateValue(with: true)
        perform(request) { (response) in
            Response.loading.updateValue(with: false)
            Response.response.updateValue(with: response)
            completion(response)
        }
    }
}

extension Session {
    static let hazeLight: Session = {
        let session = Session(interceptor: UserCredentialAdapter(), eventMonitors: [LoggingMonitor()])
        
        return session
    }()
}

final class UserCredentialAdapter: RequestInterceptor {
    private var token: NotificationToken?
    private var currentCredential: CredentialsModelController.UserCredential?
    
    init(credentials: CredentialsModelController = .shared) {
        token = credentials.currentCredential.observe { self.currentCredential = $0 }
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest>) -> Void) {
        completion(Result {
            guard urlRequest.httpHeaders["X-Auth-Email"] == nil, urlRequest.httpHeaders["X-Auth-Key"] == nil else {
                return urlRequest
            }
            
            var urlRequest = urlRequest
            
            let credential = try currentCredential.unwrapped()
            urlRequest.httpHeaders.add(.xAuthEmail(credential.email))
            urlRequest.httpHeaders.add(.xAuthKey(credential.token))
            
            return urlRequest
        })
    }
}

extension HTTPHeader {
    static func xAuthEmail(_ email: String) -> HTTPHeader {
        return HTTPHeader(name: "X-Auth-Email", value: email)
    }
    
    static func xAuthKey(_ key: String) -> HTTPHeader {
        return HTTPHeader(name: "X-Auth-Key", value: key)
    }
}

final class LoggingMonitor: EventMonitor {
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value>) {
        debugPrint(response)
        let body = request.data.map { String(decoding: $0, as: UTF8.self) } ?? "No body."
        print("[Body]: \(body)")
    }
}

enum ResourceState {
    case loading
}

protocol NetworkObservable where Self: RawResponseDecodable {
    static var loading: NotificationObservable<Bool> { get }
    static var response: NotificationObservable<DataResponse<BaseResponse<Self>>> { get }
//    static var result: NotificationObservable<Result<Self>> { get }
    static var value: NotificationObservable<Self> { get }
}

extension User: NetworkObservable {
    static let loading = NotificationObservable(initialValue: false)
    static let response = NotificationObservable<DataResponse<BaseResponse<User>>>()
//    static let result = User.response.map { $0.result.value.value }
    static let value = User.response.map { $0.result.value?.value }
}

// observable.map({ }, into: otherObservable)
// otherObservable.ingest(from: observable, using: { (currentValue) })

extension NotificationObservable {
    func map<NewValue>(observingOnQueue queue: OperationQueue = .main, _ transform: @escaping (Value) -> NewValue?) -> NotificationObservable<NewValue> {
        let observable = NotificationObservable<NewValue>()
        let token = observe(returningCurrentValue: true, queue: queue) { (value) in
            guard let newValue = transform(value) else { return }
            observable.updateValue(with: newValue)
        }
        observable.persist(token)
        
        return observable
    }
}
