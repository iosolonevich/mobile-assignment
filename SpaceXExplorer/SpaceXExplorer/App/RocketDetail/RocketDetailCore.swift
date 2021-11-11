//
//  RocketDetailCore.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import CombineSchedulers
import ComposableArchitecture

struct RocketDetailState: Equatable, Identifiable {
    let id: UUID
    var rocket: Rocket
}

enum RocketDetailAction: Equatable {
    case onDisappear
}

struct RocketDetailEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let rocketDetailReducer = Reducer<RocketDetailState, RocketDetailAction, RocketDetailEnvironment> { state, action, environment in
    
    struct RocketDetailCancelId: Hashable {}
    
    switch action {
    case .onDisappear:
        return .cancel(id: RocketDetailCancelId())
    }
}
