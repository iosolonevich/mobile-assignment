//
//  LaunchView.swift
//  SpaceXExplorer
//
//  Created by alex on 13.11.2021.
//

import SwiftUI
import ComposableArchitecture
import SpriteKit

struct LaunchView: View {
    let store: Store<LaunchState, LaunchAction>

    var body: some View {
        
        WithViewStore(self.store) { viewStore in
            VStack {
                Image("Rocket Idle")
                    .frame(width: 50, height: 50)
                    .offset(x: CGFloat(viewStore.pitch * 100), y: CGFloat(viewStore.roll * 500))
                Text("Move the phone")
            }
            .alert(self.store.scope(state: { $0.alert }), dismiss: .alertDismissed)
            .onAppear { viewStore.send(.onAppear) }
            .onDisappear { viewStore.send(.onDisappear) }
        }
    }
}

//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchView(store: .init(
//            initialState: LaunchState(
//                id: .init(),
//                rocket: .mockRocket1,
//                size: UIScreen.screenSize
//            ),
//            reducer: launchReducer,
//            environment: .init(mainQueue: DispatchQueue.main.eraseToAnyScheduler())))
//    }
//}
