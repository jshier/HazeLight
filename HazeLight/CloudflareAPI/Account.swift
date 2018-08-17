//
//  Account.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

final class Accounts {
    struct Account {
        let email: String
        let token: String
    }
    
    // let accountAddtion: Observable<AccountAdditionAttempt>
    // Accounts.shared.accountAddtion.observe { }
    // nil == nothing, non-nil == adding
    // AccountAdditionAttempt { let account: Account, let response: DataResponse }
    // Update UI for attempt coming in
    // Add -> automatically dismiss if successful, reenable UI if failed
    private var accounts: [Account] = []
    
//    func validateAccount(_ account: Account, isValid: (_ isValid: Bool) -> Void) {
//        // network.validateAccount()
//    }
//
//    func validate(email: String, token: String) -> Account {
//
//    }
    
    func addAccount(_ account: Account) {
        
    }
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
