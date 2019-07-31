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

final class NetworkValue<T: RawResponseDecodable> {
    let request: CurrentValueSubject<DataRequest?, Never> = .init(nil)
    let response: OptionalValueSubject<DataResponse<BaseResponse<T>>, Never> = .init()
    let result: OptionalValueSubject<Result<BaseResponse<T>, Error>, Never> = .init()
    let value: OptionalValueSubject<T, Never> = .init()
    
    let session: Session
    private var canceller: AnyCancellable?
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func update<Request: Requestable>(using requestable: Request) where Request.Response == T {
        canceller = session.requestPublisher(for: requestable).sink(receiveCompletion: { _ in }) { (dataRequest) in
            self.request.send(dataRequest)
            dataRequest.responseValue(queue: self.session.rootQueue) { (response: DataResponse<BaseResponse<T>>) in
                self.response.send(response)
                self.result.send(response.result)
                if case let .success(baseResponse) = response.result, let value = baseResponse.value {
                    self.value.send(value)
                }
                self.request.send(nil)
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
