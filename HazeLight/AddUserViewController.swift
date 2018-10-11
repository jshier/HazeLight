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
        
        logicController.listen { print($0) }
    }
    
    @IBAction func addUser() {
        guard let email = emailTextField.text, let token = tokenTextField.text else { return }
        
        logicController.addUser(email: email, token: token)
    }
}

final class AddUserLogicController: Listenable {
    struct State {
        let isLoading: Bool
    }
    
    private let users: UsersModelController
    private var token: NotificationToken?
    
    let listener = Listener<State>()
    
    init(users: UsersModelController = .shared) {
        self.users = users
        
        token = users.pendingCredential.observe { [weak self] (credential) in
            self?.listener.updateState(State(isLoading: (credential != nil)))
        }
    }
    
    func addUser(email: String, token: String) {
        users.addUser(email: email, token: token)
    }
}

// Validation of UI input
// Encapsulate LogicController observation
// Break strong reference cycle.
// Include debug origination information for observations.

protocol Listenable {
    associatedtype State
    
    var listener: Listener<State> { get }
}

extension Listenable {
    func listen(listener: @escaping (State) -> Void) {
        self.listener.listen(listener: listener)
    }
}

class Listener<State> {
    private var state: State? {
        didSet { state.map { listener?($0) } }
    }
    private var listener: ((State) -> Void)?
    
    func listen(listener: @escaping (State) -> Void) {
        self.listener = listener
        state.map(listener)
    }
    
    func updateState(_ state: State) {
        self.state = state
    }
}
