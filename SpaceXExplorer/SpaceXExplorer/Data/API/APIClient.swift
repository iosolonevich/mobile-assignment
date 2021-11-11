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
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError { APIError.network(error: $0) }
            .map { $0.data }
            .decode(type: T.self, decoder: decoder)
            .mapError { APIError.decoding(error: $0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
