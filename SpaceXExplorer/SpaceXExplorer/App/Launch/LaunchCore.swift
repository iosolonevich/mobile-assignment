//
//  LaunchCore.swift
//  SpaceXExplorer
//
//  Created by alex on 13.11.2021.
//

import Foundation
import CombineSchedulers
import ComposableArchitecture
import SpriteKit

struct LaunchState: Equatable, Identifiable {
    let id: UUID
    var rocket: Rocket
    var size: CGSize
    var rocketScene: SKScene {
        RocketScene(size: size)
    }
}

enum LaunchAction: Equatable {
    case onAppear(size: CGSize)
    case onDisappear
}

struct LaunchEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let launchReducer = Reducer<LaunchState, LaunchAction, LaunchEnvironment> { state, action, environment in
    
    struct LaunchCancelId: Hashable {}
    
    switch action {
    case .onDisappear:
        return .cancel(id: LaunchCancelId())
    case .onAppear(let size):
//        state.rocketScene = RocketScene(size: size)
        return .none
    }
}
