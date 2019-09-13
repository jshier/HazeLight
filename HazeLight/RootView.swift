//
//  ContentView.swift
//  HazeLight
//
//  Created by Jon Shier on 6/13/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Alamofire
import Valet
import SwiftUI

struct RootView : View {
    @State var addingAccount = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    if addingAccount {
                        AddAccountView(cancelAction: cancelAddingAccount)
                    } else {
                        Button("Add Account", action: addAccount)
                    }
                }
                Section {
                    NavigationLink(destination: AccountDetails(user: CurrentUser(user: .placeholder))) {
                        AccountCell()
                    }
                }
            }
            .navigationBarTitle("Accounts")
            .listStyle(GroupedListStyle())
        }
    }
    
    func addAccount() {
        addingAccount = true
    }
    
    func cancelAddingAccount() {
        addingAccount = false
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
