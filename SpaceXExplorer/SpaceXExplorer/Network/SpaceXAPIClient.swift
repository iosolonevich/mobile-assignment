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
    let launches: () -> Effect<Launches, APIError>
}

extension RocketsClient {
    static let live = Self(
        rockets: {
            SpaceXAPI.rockets()
                .eraseToEffect()
        },
        launches: {
            SpaceXAPI.launches()
                .eraseToEffect()
        }
    )
}

extension RocketsClient {
    static func mockPreview(
        allRockets: @escaping () -> Effect<Rockets, APIError> = {
            .init(value: [Rocket.mockRocket1, Rocket.mockRocket2])
        },
        allLaunches: @escaping () -> Effect<Launches, APIError> = {
            .init(value: [Launch]())
        }
    ) -> Self {
        Self(rockets: allRockets, launches: allLaunches)
    }
}
