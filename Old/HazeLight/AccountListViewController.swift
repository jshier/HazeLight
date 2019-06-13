//
//  AccountListViewController.swift
//  HazeLight
//
//  Created by Jon Shier on 2/28/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import UIKit

final class AccountListViewController: UITableViewController {
    private let credentials = CredentialsModelController.shared
    private var token: NotificationToken?
    private var allCredentials: [CredentialsModelController.UserCredential] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = credentials.allCredentials.observe { [weak self] in self?.allCredentials = $0 }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
        cell.textLabel?.text = allCredentials[indexPath.row].email
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCredentials.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        credentials.setCurrentCredential(at: indexPath.row)
        performSegue(withIdentifier: "showUserDetails", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard case .delete = editingStyle else { return }
        
        credentials.removeCredential(id: allCredentials[indexPath.row].id)
    }
}
