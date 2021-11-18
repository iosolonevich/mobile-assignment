//
//  Route.swift
//  SpaceXExplorer
//
//  Created by alex on 18.11.2021.
//

import Foundation

struct Route {
    let path: String
    let queryItems:[URLQueryItem]?
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.queryItems = queryItems
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spacexdata.com"
        components.path = "/v4/\(path)"
        components.queryItems = queryItems

        return components.url
    }
}
