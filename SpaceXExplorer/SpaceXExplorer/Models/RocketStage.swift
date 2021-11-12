//
//  RocketStage.swift
//  SpaceXExplorer
//
//  Created by alex on 12.11.2021.
//

import Foundation

protocol RocketStageProtocol {
    var reusable: Bool { get }
    var engines: Int { get }
    var fuelAmountTons: Double { get }
    var burnTimeSEC: Int? { get }
}

extension FirstStage: RocketStageProtocol {}

extension SecondStage: RocketStageProtocol {}

struct RocketStage: Identifiable, Equatable {
    let id: UUID
    let isReusable, enginesCount, fuelMassT, burnTimeSeconds: String
}
