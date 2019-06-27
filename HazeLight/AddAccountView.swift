//
//  AddAccount.swift
//  HazeLight
//
//  Created by Jon Shier on 6/13/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct AddAccountView : View {
    let cancelAction: () -> Void
    
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
            HStack {
                Button(action: cancelAddingAccount) {
                    Text("Cancel")
                }
                Spacer()
                Button(action: addAccount) {
                    Text("Add Account")
                        .fontWeight(.bold)
                }
            }
        }
        .padding()
    }
    
    func addAccount() {
        
    }
    
    func cancelAddingAccount() {
        cancelAction()
    }
}

#if DEBUG
struct AddAccount_Previews : PreviewProvider {
    static var previews: some View {
        AddAccountView(cancelAction: {})
    }
}
#endif
