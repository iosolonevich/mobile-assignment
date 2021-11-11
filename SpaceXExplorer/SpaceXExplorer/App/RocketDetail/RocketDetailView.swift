//
//  RocketDetailView.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import SwiftUI
import ComposableArchitecture

struct RocketDetailView: View {
    let store: Store<RocketDetailState, RocketDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text("Description")
                    .font(.headline)
                Text(viewStore.rocket.rocketDescription)
                
            }
        }
    }
}

struct RocketDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RocketDetailView(
                store: .init(
                    initialState: RocketDetailState(
                        id: .init(),
                        rocket: .mockRocket1
                    ),
                    reducer: rocketDetailReducer,
                    environment: .init(
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                    )
                )
            )
        }
    }
}
