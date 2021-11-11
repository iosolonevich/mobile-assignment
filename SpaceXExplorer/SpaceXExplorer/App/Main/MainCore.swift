//
//  MainCore.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import ComposableArchitecture

struct MainState: Equatable {
    var rocketsState = RocketsState()
    
    enum Tab {
        case rockets
    }
    
    var selectedTab = Tab.rockets
}

enum MainAction {
    case rockets(RocketsAction)
    
    case selectedTabChange(MainState.Tab)
}

struct MainEnvironment {
    var rocketsClient: RocketsClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

let mainReducer: Reducer<MainState, MainAction, MainEnvironment> = .combine(
    rocketsReducer.pullback(
        state: \MainState.rocketsState,
        action: /MainAction.rockets,
        environment: { environment in
//            let rocketsDateFormatter = DateFormatter()
//            rocketsDateFormatter.dateFormat = "dd.MM.yyyy"
            
            return RocketsEnvironment(
                rocketsClient: environment.rocketsClient,
                mainQueue: environment.mainQueue,
//                dateFormatter: rocketsDateFormatter,
                uuid: environment.uuid
            )
        }
    ),
    .init { state, action, environment in
        switch action {
        case .rockets:
            return .none
        case .selectedTabChange(let selectedTab):
            state.selectedTab = selectedTab
            return .none
        }
    }
)
