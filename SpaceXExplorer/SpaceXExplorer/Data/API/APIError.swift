//
//  APIError.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation

enum APIError: Error, Equatable {
    case network(error: Error)
    case decoding(error: Error)
    case error(error: Error)
    case notFound
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs){
        case (.network, .network):
            return true
        case (.decoding, .decoding):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }
}
