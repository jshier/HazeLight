//
//  ViewController.swift
//  HazeLight
//
//  Created by Jon Shier on 8/9/18.
//  Copyright © 2018 Jon Shier. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet var accountNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let logicController = LogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController.observe { [weak self] (state) in
            self?.accountNameLabel.text = state.latestUser.id
            self?.dateLabel.text = Date().description + " \(String(describing: self))"
        }
    }
}

extension ViewController {
    final class LogicController: ObservableLogicController<LogicController.State> {
        struct State {
            let latestUser: User
        }
        
        private let users: UsersModelController
        
        init(users: UsersModelController = .shared) {
            self.users = users
            
            super.init()
            
            addObservations { [weak self] in
                [users.currentUser.observe { self?.state = State(latestUser: $0) }]
            }
        }
    }
}
