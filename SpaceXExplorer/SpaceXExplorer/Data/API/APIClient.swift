//
//  APIClient.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import Combine

struct APIClient {
    
    func request<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, APIError> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError { APIError.network(error: $0) }
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { APIError.decoding(error: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
