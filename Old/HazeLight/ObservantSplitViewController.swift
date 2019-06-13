//
//  ObservantSplitViewController.swift
//  HazeLight
//
//  Created by Jon Shier on 2/21/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import UIKit

class ObservantSplitViewController: UISplitViewController {
    private let logicController = LogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController.observe { _ in
            //self.showDetailViewController(controller, sender: nil)
        }
    }
}

extension ObservantSplitViewController {
    final class LogicController: ObservableLogicController<LogicController.State> {
        struct State {
            let userDidChange: Bool
        }
        
        private let users: UsersModelController
        
        init(users: UsersModelController = .shared) {
            self.users = users
            
            super.init()
            
            addObservations { [weak self] in
                [users.currentUser.observe { _ in self?.state = State(userDidChange: true) }]
            }
        }
    }
}
