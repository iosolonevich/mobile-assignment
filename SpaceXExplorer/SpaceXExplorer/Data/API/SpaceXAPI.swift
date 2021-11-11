//
//  SpaceXAPI.swift
//  SpaceXExplorer
//
//  Created by alex on 10.11.2021.
//

import Foundation
import Combine

enum SpaceXAPI {
    
    private static let base = URL(string: "https://api.spacexdata.com/v4/")!
    private static let apiClient = APIClient()
    
    static func getRockets() -> AnyPublisher<Rockets, APIError> {
        let request = URLComponents(url: base.appendingPathComponent("rockets"), resolvingAgainstBaseURL: true)?
            .request
        return apiClient.request(request!)
    }
}

private extension URLComponents {
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}
