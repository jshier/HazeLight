//
//  AddUserViewController.swift
//  HazeLight
//
//  Created by Jon Shier on 9/13/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import UIKit

final class AddUserViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var tokenTextField: UITextField!
    
    private let logicController = AddUserLogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // logicController.listen { }
    }
    
    @IBAction func addUser() {
        guard let email = emailTextField.text, let token = tokenTextField.text else { return }
        
        logicController.addUser(email: email, token: token)
    }
}

final class AddUserLogicController {
    let users: UsersModelController
    
    init(users: UsersModelController = .shared) {
        // Add observations to other bits
        // users.observe { }
        // Pending user add
        // Sees result
        self.users = users
    }
    
    func addUser(email: String, token: String) {
        users.addUser(email: email, token: token)
    }
}

// Validation of UI input
