//
//  SpaceXAPI.swift
//  SpaceXExplorer
//
//  Created by alex on 18.11.2021.
//

import Foundation
import Combine

struct SpaceXAPI {
    
    static func rockets() -> AnyPublisher<Rockets, APIError> {
        let route = Route(path: "rockets")
        if let url = route.url {
            let request = URLRequest(url: url)
            return URLSession.shared.requestPublisher(request)
        } else {
            return Fail(error: APIError.error(errorMessage: "Couldn't get the API's URL for rockets"))
                .eraseToAnyPublisher()
        }
    }
    
    static func launches() -> AnyPublisher<Launches, APIError> {
        
        
        
        return Fail(error: APIError.error(errorMessage: "Not implemented"))
            .eraseToAnyPublisher()
    }
}
