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
            if addingAccount {
                AddAccount()
            } else {
                Button(action: addAccount) { Text("Add Account") }
            }
            List {
                NavigationButton(destination: AccountDetails()) {
                    AccountCell()
                }
            }
            .navigationBarTitle(Text("Accounts"))
            .navigationBarItems(trailing:
                    PresentationButton(destination: AddAccount()) {
                        Image(systemName: "plus.circle").imageScale(.large)
                    })
        }
    }
    
    func addAccount() {
        addingAccount = true
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
