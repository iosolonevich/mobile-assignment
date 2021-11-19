//
//  RocketsCore.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import IdentifiedCollections
import CombineSchedulers
import ComposableArchitecture

struct RocketsState: Equatable {
    var rockets = IdentifiedArrayOf<RocketDetailState>()
    var isLoading = false
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
}

enum RocketsAction: Equatable {
    case getRockets
    case rocketsResponse(Result<Rockets, APIError>)
    
    case loadingActive(Bool)
    
    case rocket(id: UUID, action: RocketDetailAction)
    
    case onAppear
    case onDisappear
}

struct RocketsEnvironment {
    var rocketsClient: RocketsClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var uuid: () -> UUID
}

let rocketsReducer = Reducer<RocketsState, RocketsAction, RocketsEnvironment>.combine(
    
    rocketDetailReducer.forEach(
        state: \.rockets,
        action: /RocketsAction.rocket(id:action:),
        environment: { environment in
                .init(mainQueue: environment.mainQueue)
        }
    ),
    
    .init { state, action, environment in
        
        struct RocketsCancelId: Hashable {}
        
        switch action {
        case .onAppear:
            return .init(value: .getRockets)
        
        case .getRockets:
            state.rockets = []
            return environment.rocketsClient.rockets()
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(RocketsAction.rocketsResponse)
                .cancellable(id: RocketsCancelId())
        
        case .rocketsResponse(.success(let rockets)):
            let rocketItems = IdentifiedArrayOf<RocketDetailState>(
                uniqueElements: rockets.map {
                    RocketDetailState(id: environment.uuid(), rocket: $0)
                }
            )
            state.rockets = rocketItems
            return .init(value: .loadingActive(false))
        
        case .rocketsResponse(.failure(let error)):
            return .init(value: .loadingActive(false))
        
        case .loadingActive(let isLoading):
            state.isLoading = isLoading
            return .none
        
        case .rocket(id: _, action: _):
            return .none
        
        case .onDisappear:
            return .cancel(id: RocketsCancelId())
        }
    }
)
