//
//  MainView.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    let store: Store<MainState, MainAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            TabView(
                selection: viewStore.binding(
                    get: { $0.selectedTab },
                    send: MainAction.selectedTabChange),
                content: {
                    Group {
                        RocketsView(store: rocketsStore)
                            .tabItem {
                                Image(systemName: "paperplane.circle")
                                Text("Rockets")
                            }
                            .tag(MainState.Tab.rockets)
                    }
                }
            )
        }
    }
}

extension MainView {
    private var rocketsStore: Store<RocketsState, RocketsAction> {
        return store.scope(
            state: { $0.rocketsState },
            action: MainAction.rockets
        )
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
