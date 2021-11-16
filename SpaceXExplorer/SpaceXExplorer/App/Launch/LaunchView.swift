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
        WithViewStore(store) { viewStore in
            if let scene = viewStore.rocketScene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
//                    .onAppear {
//                        viewStore.send(.onAppear(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)))
//                    }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(store: .init(
            initialState: LaunchState(
                id: .init(),
                rocket: .mockRocket1,
                size: UIScreen.screenSize
            ),
            reducer: launchReducer,
            environment: .init(mainQueue: DispatchQueue.main.eraseToAnyScheduler())))
    }
}
