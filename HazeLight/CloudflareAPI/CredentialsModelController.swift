//
//  CredentialsModelController.swift
//  HazeLight
//
//  Created by Jon Shier on 12/20/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation
import Valet

final class CredentialsModelController {
    struct UserCredential: Codable {
        let email: String
        let token: String
    }
    
    static let shared = CredentialsModelController()
    
    let storage: CredentialStorage
    let network: NetworkController
    
    let allCredentials = NotificationObservable<[UserCredential]>()
    let currentCredential = NotificationObservable<UserCredential?>()
    let isVerifyingCredential = NotificationObservable<Bool>()
    
    init(storage: CredentialStorage = Keychain.shared, network: NetworkController = .shared) {
        self.storage = storage
        self.network = network
        
        allCredentials.updateValue(with: storage.allCredentials)
        currentCredential.updateValue(with: storage.currentCredential)
        isVerifyingCredential.updateValue(with: false)
    }
    
    // TODO: Properly synchronize observable update and storage.
    func addCredential(email: String, token: String) {
        isVerifyingCredential.updateValue(with: true)
        network.validate(email: email, token: token) { (response) in
            self.isVerifyingCredential.updateValue(with: false)
            response.result.ifSuccess {
                let credential = UserCredential(email: email, token: token)
                self.storage.allCredentials.append(credential)
                self.allCredentials.appendValue(with: credential)
                
                self.storage.currentCredential = credential
                self.currentCredential.updateValue(with: credential)
            }
        }
    }
}

protocol CredentialStorage: AnyObject {
    var allCredentials: [CredentialsModelController.UserCredential] { get set }
    var currentCredential: CredentialsModelController.UserCredential? { get set }
}

final class Keychain {
    enum Key: String {
        case currentCredential, allCredentials
    }
    
    static let shared = Keychain()
    
    let valet = Valet.valet(with: Identifier(nonEmpty: "com.hazelight.keychain")!, accessibility: .whenUnlocked)
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    func setValue<T: Codable>(_ value: T, for key: Key) {
        valet.set(object: try! encoder.encode(value), forKey: key.rawValue)
    }
    
    func value<T: Codable>(forKey key: Key) -> T? {
        return valet.object(forKey: key.rawValue).map { try! decoder.decode(T.self, from: $0) }
    }
}

extension Keychain: CredentialStorage {
    var allCredentials: [CredentialsModelController.UserCredential] {
        get { return value(forKey: .allCredentials) ?? [] }
        set { setValue(newValue, for: .allCredentials) }
    }
    
    var currentCredential: CredentialsModelController.UserCredential? {
        get { return value(forKey: .currentCredential) }
        set { setValue(newValue, for: .currentCredential) }
    }
}
