//
//  AccountCell.swift
//  HazeLight
//
//  Created by Jon Shier on 6/13/19.
//  Copyright © 2019 Jon Shier. All rights reserved.
//

import SwiftUI

struct AccountCell : View {
    // enum State {
    // @EvironmentObject var networkState: NetworkState
    // @State var state: State
    var body: some View {
        Text("Account Cell")
        // switch state
        // if networkState.current.isLoading { Text("Loading") } else { Text(networkState.currentUser.name) }
        // (networkState.currentUser, networkState.userBillInfo, networkState.something)
    }
}

#if DEBUG
struct AccountCell_Previews : PreviewProvider {
    static var previews: some View {
        AccountCell()
    }
}
#endif
