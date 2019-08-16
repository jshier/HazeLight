//
//  NetworkValue.swift
//  HazeLight
//
//  Created by Jon Shier on 6/27/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import Combine
import Foundation

final class NetworkValue<T: Decodable> {
    let request: CurrentValueSubject<DataRequest?, Never> = .init(nil)
    let response: OptionalValueSubject<DataResponse<T>, Never> = .init()
    let result: OptionalValueSubject<Result<T, Error>, Never> = .init()
    let value: OptionalValueSubject<T, Never> = .init()
    
    let session: Session
    private var canceller: AnyCancellable?
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func update<Request: URLRequestConvertible>(using requestable: Request) {
//        let publisher = session.requestPublisher(for: requestable)
//            .handleEvents(receiveOutput: {
//                self.request.send($0)
//            })
//            .response(of: T.self, queue: session.rootQueue, decoder: JSONDecoder())
//            .handleEvents(receiveOutput: { response in
//                self.response.send(response)
//                self.result.send(response.result)
//                if case let .success(value) = response.result { self.value.send(value) }
//                self.request.send(nil)
//                self.canceller = nil
//            })
//        .eraseToAnyPublisher()
//
//        canceller = AnyCancellable(publisher)
            
        canceller = session.requestPublisher(for: requestable).sink { request in
            self.request.send(request)
            request.responseDecodable(of: T.self, queue: self.session.rootQueue, decoder: JSONDecoder()) { (response) in
                self.response.send(response)
                self.result.send(response.result)
                if case let .success(value) = response.result { self.value.send(value) }
                self.request.send(nil)
                self.canceller = nil
            }
        }
    }
}

final class OptionalValueSubject<Output, Failure>: Subject where Failure: Error {
    private var currentValueSubject = CurrentValueSubject<Output?, Failure>(nil)
    
    func send(_ value: Output) {
        currentValueSubject.send(value)
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
        currentValueSubject.send(completion: completion)
    }
    
    func send(subscription: Subscription) {
        currentValueSubject.send(subscription: subscription)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        currentValueSubject.compactMap { $0 }.receive(subscriber: subscriber)
    }
}
