//
//  LaunchCore.swift
//  SpaceXExplorer
//
//  Created by alex on 13.11.2021.
//

import Foundation
import ComposableArchitecture
import CoreMotion
import ComposableCoreMotion

struct LaunchState: Equatable, Identifiable {
    let id: UUID
    var rocket: Rocket
    var rocketInitialAttitude: Attitude?
    var alert: AlertState<LaunchAction>?
    var pitch: Double = 0.0
    var roll: Double = 0.0
}

enum LaunchAction: Equatable {
    case onAppear
    case onDisappear
    case motionUpdate(Result<DeviceMotion, NSError>)
    case alertDismissed
}

struct LaunchEnvironment {
    var motionManager: MotionManager
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let launchReducer = Reducer<LaunchState, LaunchAction, LaunchEnvironment> { state, action, environment in
    struct MotionManagerId: Hashable {}
    
    switch action {
    case .alertDismissed:
        state.alert = nil
        return .none
        
    case .motionUpdate(.failure):
        state.alert = .init(
            title: .init(
            """
            A problem occured during a rocket launch. Make sure you launch the rocket on a physical device, not the simulator
            """
            )
        )
        return .init(value: .onDisappear)
        
    case .motionUpdate(.success(let motion)):
        state.rocketInitialAttitude =
            state.rocketInitialAttitude
            ?? environment.motionManager.deviceMotion(id: MotionManagerId())?.attitude
        
        state.pitch = motion.attitude.pitch
        state.roll = motion.attitude.roll
        
        return .none
        
    case .onAppear:
        return .concatenate(
            environment.motionManager
                .create(id: MotionManagerId())
                .fireAndForget(),
            
            environment.motionManager
                .startDeviceMotionUpdates(id: MotionManagerId(), using: .xArbitraryZVertical, to: .main)
                .mapError { $0 as NSError }
                .catchToEffect()
                .map(LaunchAction.motionUpdate)
        )

    case .onDisappear:
        state.rocketInitialAttitude = nil
        return .concatenate(
            environment.motionManager
                .stopDeviceMotionUpdates(id: MotionManagerId())
                .fireAndForget(),
            
            environment.motionManager
                .destroy(id: MotionManagerId())
                .fireAndForget()
        )
    }
}
