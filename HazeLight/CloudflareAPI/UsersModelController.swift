//
//  Account.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

final class UsersModelController {
    struct UserCredential {
        let email: String
        let token: String
    }
    
    static let shared = UsersModelController()
    
    let credentials = Observer<[UserCredential]>()
    let currentCredential = Observer<UserCredential?>()
    let pendingCredential = Observer<UserCredential?>()
    
    private let network: NetworkController
    
    init(network: NetworkController = .shared) {
        self.network = network
    }
    
    func addUser(email: String, token: String) {
        let credential = UserCredential(email: email, token: token)
        pendingCredential.updateValue(with: credential)
        
        network.fetchUser { (response) in
            self.pendingCredential.updateValue(with: nil)
            response.result.ifSuccess {
                self.currentCredential.updateValue(with: credential)
                self.credentials.appendValue(with: credential)
            }
            
            print("Fetch user was: \(response.result)")
        }
        // Pending credential
        // Observe something
        // On return, update list of credentials?
    }
    
    // let accountAddtion: Observable<AccountAdditionAttempt>
    // Accounts.shared.accountAddtion.observe { }
    // nil == nothing, non-nil == adding
    // AccountAdditionAttempt { let account: Account, let response: DataResponse }
    // Update UI for attempt coming in
    // Add -> automatically dismiss if successful, reenable UI if failed
//    private var accounts: [Account] = []
    
//    func validateAccount(_ account: Account, isValid: (_ isValid: Bool) -> Void) {
//        // network.validateAccount()
//    }
//
//    func validate(email: String, token: String) -> Account {
//
//    }
    
//    func addAccount(_ account: Account) {
//
//    }
}

// validateAccount()
// validationAttempt(account, isValid)
// observe Accounts.validationAttempts
// lastValidation: Account =
// attempt comes back

// typing -> latestValidatingAccount = account.validate(emailTextField.text, token...) ->
// observe accounts for successful addition
// future, response, values,
// accountAdditionAttempt(response)

protocol UserStorage {
    
}
