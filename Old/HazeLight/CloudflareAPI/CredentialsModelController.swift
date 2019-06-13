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
    struct UserCredential: Equatable, Codable {
        let id: UUID
        let email: String
        let token: String
        
        init(id: UUID = UUID(), email: String, token: String) {
            self.id = id
            self.email = email
            self.token = token
        }
    }
    
    static let shared = CredentialsModelController()
    
    let storage: CredentialStorage
    let network: NetworkController
    
    let allCredentials: NotificationObservable<[UserCredential]>
    let currentCredential: NotificationObservable<UserCredential?>
    let isVerifyingCredential: NotificationObservable<Bool>
    
    init(storage: CredentialStorage = Keychain.shared, network: NetworkController = .shared) {
        self.storage = storage
        self.network = network
        
        allCredentials = NotificationObservable(initialValue: storage.allCredentials)
        currentCredential = NotificationObservable(initialValue: storage.currentCredential)
        isVerifyingCredential = NotificationObservable(initialValue: false)
    }
    
    // TODO: Properly synchronize observable update and storage.
    func addCredential(email: String, token: String) throws {
        guard !storage.allCredentials.contains(UserCredential(email: email, token: token)) else {
            throw Error.duplicateCredential
        }
        
        isVerifyingCredential.updateValue(with: true)
        network.validate(email: email, token: token) { (response) in
            self.isVerifyingCredential.updateValue(with: false)
            if case .success = response.result {
                let credential = UserCredential(email: email, token: token)
                self.storage.allCredentials.append(credential)
                self.allCredentials.appendValue(with: credential)
                
                self.storage.currentCredential = credential
                self.currentCredential.updateValue(with: credential)
            }
        }
    }
    
    func setCurrentCredential(at index: Int) {
        currentCredential.updateValue(with: storage.allCredentials[index])
    }
    
    func removeCredential(id: UUID) {
        allCredentials.removeAll { $0.id == id }
        storage.allCredentials.removeAll { $0.id == id }
        if currentCredential.value??.id == id {
            currentCredential.updateValue(with: nil)
            storage.currentCredential = nil
        }
    }
}

extension CredentialsModelController {
    enum Error: Swift.Error {
        case duplicateCredential
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
    
    func setValue<T: Codable>(_ value: T?, for key: Key) {
        if let value = value {
            valet.set(object: try! encoder.encode(value), forKey: key.rawValue)
        } else {
            valet.removeObject(forKey: key.rawValue)
        }
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
