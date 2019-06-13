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
    
    private let logicController = LogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController.observe { print($0) }
    }
    
    @IBAction func addUser() {
        guard let email = emailTextField.text, let token = tokenTextField.text else { return }
        
        do {
            try logicController.addUser(email: email, token: token)
        } catch {
            emailTextField.text = ""
            tokenTextField.text = ""
            emailTextField.placeholder = error.localizedDescription
        }
    }
    
    @IBAction func editUser(_ sender: UIButton) {
        logicController.editUser()
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}

extension AddUserViewController {
    final class LogicController: ObservableLogicController<LogicController.State> {
        struct State {
            let isLoading: Bool
        }
        
        private let users: UsersModelController
        
        init(users: UsersModelController = .shared) {
            self.users = users
            
            super.init(state: .init(isLoading: false))
            
            addObservations { [weak self] in
                [self?.users.isAddingUser.observe { self?.state = State(isLoading: $0) }]
            }
        }
        
        func addUser(email: String, token: String) throws {
            try users.addUser(email: email, token: token)
        }
        
        func editUser() {
            users.editCurrentUser(zipCode: "48421")
        }
    }
}

class ObservableLogicController<State>: Observable {
    var state: State? {
        didSet {
            state.map { observer?($0) }
        }
    }
    
    private var observer: Observation?
    private var tokens: [NotificationToken] = []
    
    init(state: State? = nil) {
        self.state = state
    }
    
    func observe(returningCurrentValue: Bool = true,
                 queue: OperationQueue = .main,
                 handler: @escaping (State) -> Void) {
        observer = { state in
            queue.addOperation { handler(state) }
        }
        
        if returningCurrentValue {
            state.map { observer?($0) }
        }
    }
    
    func addObservations(_ observations: () -> [NotificationToken?]) {
        tokens += observations().compactMap { $0 }
    }
}

// Validation of UI input
// Encapsulate LogicController observation
// Break strong reference cycle.
// Include debug origination information for observations.

class ClosureObservable<State> {
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
