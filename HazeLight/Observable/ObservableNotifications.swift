//
//  ObservableNotifications.swift
//  HazeLight
//
//  Created by Jon Shier on 10/11/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

extension NotificationCenter {
    /// Convenience wrapper for addObserver(forName:object:queue:using:) that returns a `NotificationToken`.
    public func observe(notificationNamed name: NSNotification.Name?,
                        object: Any? = nil,
                        queue: OperationQueue? = .main,
                        using block: @escaping (Notification) -> Void) -> NotificationToken {
        let token = addObserver(forName: name, object: object, queue: queue, using: block)
        
        return NotificationToken(notificationCenter: self, token: token)
    }
    
    /// Convenience function to post a notification with a generic payload.
    public func postNotification<Payload>(named name: Notification.Name, with payload: Payload) {
        let notification = Notification(name: name, payload: payload)
        post(notification)
    }
}

public extension Notification {
    public init<Payload>(name: Notification.Name, payload: Payload) {
        self.init(name: name, object: nil, userInfo: [String.payload: payload])
    }
    
    public func payload<Payload>() -> Payload {
        guard let payload = userInfo?[String.payload] as? Payload else {
            fatalError("Unexpected payload type: \(Payload.self)")
        }
        
        return payload
    }
    
    public func transform<T, U>(_ closure: (_ payload: T) -> U) -> U {
        return closure(payload())
    }
}

/// Wraps the observer token received from NotificationCenter.addObserver(forName:object:queue:using:)
/// and unregisters it in deinit.
public final class NotificationToken: NSObject {
    let notificationCenter: NotificationCenter
    let token: Any
    
    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }
    
    deinit {
        notificationCenter.removeObserver(token)
    }
}

private extension String {
    static let payload = "payload"
}
