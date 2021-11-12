//
//  RocketParameter.swift
//  SpaceXExplorer
//
//  Created by alex on 12.11.2021.
//

import Foundation

struct RocketParameter: Identifiable, Equatable {
    let id: UUID
    let parameterName, parameterValue: String
}
