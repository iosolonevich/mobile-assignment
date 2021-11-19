//
//  RocketDetailCore.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import ComposableArchitecture

struct RocketDetailState: Equatable, Identifiable {
    let id: UUID
    var rocket: Rocket
    var rocketParameters: [RocketParameter] {
        getRocketParameters(for: rocket)
    }
    var rocketStages: [RocketStage] {
        [
            getRocketStageDescription(for: rocket.firstStage),
            getRocketStageDescription(for: rocket.secondStage)
        ]
    }
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

private func getRocketParameters(for rocket: Rocket) -> [RocketParameter] {
    var rocketParameters = [RocketParameter]()
    
    if let heightMeters = rocket.height.meters {
        rocketParameters.append(
            RocketParameter(id: UUID.init(), parameterName: "height", parameterValue: "\(Int(heightMeters))m"))
    }
    
    if let diameterMeters = rocket.diameter.meters {
        rocketParameters.append(
            RocketParameter(id: UUID.init(), parameterName: "diameter", parameterValue: "\(Int(diameterMeters))m"))
    }
    
    rocketParameters.append(
        RocketParameter(id: UUID.init(), parameterName: "mass", parameterValue: "\(rocket.mass.kg / 1000)t"))
    
    let landingLegsNumber = rocket.landingLegs.number == 0 ? "none" : String(rocket.landingLegs.number)
    rocketParameters.append(
        RocketParameter(id: UUID.init(), parameterName: "landing legs", parameterValue: landingLegsNumber))
    
    return rocketParameters
}

private func getRocketStageDescription(for rocketStage: RocketStageType) -> RocketStage {
    
    let reusability = rocketStage.reusable ? "reusable" : "not reusable"
    let enginesCount = "\(rocketStage.engines) \(rocketStage.engines > 1 ? "engines" : "engine")"
    let fuelMass = "\(Int(rocketStage.fuelAmountTons)) \(rocketStage.fuelAmountTons == 1 ? "ton" : "tons") of fuel"
    
    let burnTimeString: String
    if let burnTime = rocketStage.burnTimeSEC {
        burnTimeString = "\(burnTime) \(burnTime == 1 ? "second" : "seconds") burn time"
    } else {
        burnTimeString = "burn time not available"
    }
        
    return RocketStage(
        id: UUID.init(),
        isReusable: reusability,
        enginesCount: enginesCount,
        fuelMassT: fuelMass,
        burnTimeSeconds: burnTimeString
    )
}
