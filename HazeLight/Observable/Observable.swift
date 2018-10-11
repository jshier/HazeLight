//
//  Observable.swift
//  HazeLight
//
//  Created by Jon Shier on 10/11/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

//public protocol Observable {
//    static var observable: Observer<Self> { get }
//}
//
//public protocol NetworkObservable {
//    static var future: Observer<ResponseFuture<Self>?> { get }
//    static var response: Observer<DataResponse<Self>> { get }
//    static var value: Observer<Self> { get }
//}
//
//extension NetworkObservable {
//    static func update(with future: ResponseFuture<Self>) {
//        Self.future.updateValue(with: future)
//        future.then { (response) in
//            Self.response.updateValue(with: response)
//            response.result.withValue { Self.value.updateValue(with: $0) }
//            Self.future.updateValue(with: nil)
//        }
//    }
//}

// All updates go through `updateValue(with:)`.
public final class Observer<Value> {
    public typealias ObservationClosure<T> = (_ value: T) -> Void
    
    public private(set) var value: Value?
    
    private let center: NotificationCenter
    public let name: Notification.Name
    
    public init(name: String = UUID().uuidString, center: NotificationCenter = .default) {
        self.name = Notification.Name(rawValue: name)
        self.center = center
    }
    
    public func updateValue(with value: Value) {
        self.value = value
        
        center.postNotification(named: name, with: value)
    }
    
    public func observe(returningCurrentValue: Bool = true,
                        queue: OperationQueue = .main,
                        handler: @escaping ObservationClosure<Value>) -> NotificationToken {
        if returningCurrentValue, let value = value {
            handler(value)
        }
        
        return center.observe(notificationNamed: name, queue: queue) { handler($0.payload()) }
    }
}

extension Observer where Value: RangeReplaceableCollection {
    func appendValue(with value: Value.Element) {
        self.value?.append(value)
    }
}
