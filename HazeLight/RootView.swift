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
    var body: some View {
        NavigationView {
            List {
                NavigationButton(destination: AccountDetails()) {
                    AccountCell()
                }
            }
            .navigationBarTitle(Text("Accounts"))
            .navigationBarItems(trailing:
                    PresentationButton(
                        Image(systemName: "plus.circle").imageScale(.large),
                        destination: AddAccount()))
        }
    }
    
    func addAccount() {
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
