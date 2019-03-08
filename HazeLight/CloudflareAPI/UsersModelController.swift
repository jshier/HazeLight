//
//  Account.swift
//  HazeLight
//
//  Created by Jon Shier on 8/17/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import Foundation

final class UsersModelController {
    static let shared = UsersModelController()
    
    private let network: NetworkController
    private let credentialsController: CredentialsModelController
    
    private var token: NotificationToken?
    
    lazy var isAddingUser = credentialsController.isVerifyingCredential
    lazy var currentUser = User.value
    
    init(network: NetworkController = .shared, credentialsController: CredentialsModelController = .shared) {
        self.network = network
        self.credentialsController = credentialsController
        
        token = credentialsController.currentCredential.observe { [weak self] _ in self?.fetchUser() }
    }
    
    func fetchUser() {
        network.fetchUser { _ in }
    }
    
    func addUser(email: String, token: String) throws {
        try credentialsController.addCredential(email: email, token: token)
    }
    
    func editCurrentUser(zipCode: String) {
        network.editUser(User.Edit(zipCode: zipCode)) { (response) in
            print(response.result)
        }
    }
}
