//
//  AddAccount.swift
//  HazeLight
//
//  Created by Jon Shier on 6/13/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct AddAccount : View {
    @State private var email = ""
    @State private var token = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cloudflare Email Address")
            TextField($email, placeholder: Text("Email Address"))
                .padding()
            Text("Cloudflare API Token")
            TextField($token, placeholder: Text("Cloudflare API Token"))
                .padding()
            Button(action: addAccount) {
                Text("Add Account")
            }
        }
        .padding()
    }
    
    func addAccount() {
        
    }
}

#if DEBUG
struct AddAccount_Previews : PreviewProvider {
    static var previews: some View {
        AddAccount()
    }
}
#endif
