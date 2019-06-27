//
//  AccountDetails.swift
//  HazeLight
//
//  Created by Jon Shier on 6/13/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import Combine
import SwiftUI

struct AccountDetails : View {
    @ObjectBinding var user: CurrentUser
    
    var body: some View {
        VStack {
            Text(user.user.id)
            Text(user.user.username)
        }
    }
}

final class CurrentUser: BindableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    init(user: User) {
        self.user = user
    }
    
    var user: User {
        didSet {
            didChange.send()
        }
    }
}

#if DEBUG
struct AccountDetails_Previews : PreviewProvider {
    static var previews: some View {
        AccountDetails(user: CurrentUser(user: .placeholder))
    }
}
#endif
