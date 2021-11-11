//
//  RocketsClient.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import Combine
import ComposableArchitecture

struct RocketsClient {
    let rockets: () -> Effect<Rockets, APIError>
}

extension RocketsClient {
    static let live = Self(
        rockets: {
            SpaceXAPI.getRockets()
                .eraseToEffect()
        }
    )
}

extension RocketsClient {
    static func mockPreview(all: @escaping () -> Effect<Rockets, APIError> = {
        .init(value: [Rocket.mockRocket1, Rocket.mockRocket2])
    }) -> Self {
        Self(rockets: all)
    }
}
