//
//  APIClient.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import Combine

extension URLSession {
    
    func requestPublisher<T:Codable>(_ request: URLRequest) -> AnyPublisher<T, APIError> {
        self.dataTaskPublisher(for: request)
            .mapError(APIError.network)
            .flatMap { self.requestDecoder(data: $0.data) }
            .eraseToAnyPublisher()
    }
    
    private func requestDecoder<T: Codable>(data: Data) -> AnyPublisher<T, APIError> {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return Just(data)
            .tryMap { try decoder.decode(T.self, from: $0) }
            .mapError(APIError.decoding)
            .eraseToAnyPublisher()
    }
}
