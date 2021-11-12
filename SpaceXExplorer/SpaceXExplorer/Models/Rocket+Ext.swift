//
//  Rocket+Ext.swift
//  SpaceXExplorer
//
//  Created by alex on 12.11.2021.
//

import Foundation

// MARK: Mock
extension Rocket {
    static var mockRocket1: Rocket {
        let firstFlightString = "2018-02-05"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstFlight = dateFormatter.date(from: firstFlightString) else { fatalError() }
        return Rocket(
            height: Diameter(meters: 150, feet: 492),
            diameter: Diameter(meters: 30, feet: 98),
            mass: Mass(kg: 1200000, lb: 2645547),
            firstStage: FirstStage(reusable: true, engines: 9, fuelAmountTons: 385, burnTimeSEC: 162),
            secondStage: SecondStage(reusable: false, engines: 1, fuelAmountTons: 90, burnTimeSEC: 397),
            landingLegs: LandingLegs(number: 12, material: "stainless steel"),
            name: "Big rocket 123",
            type: "Big rocket",
            active: true,
            firstFlight: firstFlight,
            country: "USA",
            company: "SpaceX",
            wikipedia: "wikipedia link 1",
            rocketDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            id: "id1")
    }
    
    static var mockRocket2: Rocket {
        let firstFlightString = "2020-05-02"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstFlight = dateFormatter.date(from: firstFlightString) else { fatalError() }
        return Rocket(
            height: Diameter(meters: 100, feet: 328),
            diameter: Diameter(meters: 30, feet: 65),
            mass: Mass(kg: 600000, lb: 1322773),
            firstStage: FirstStage(reusable: false, engines: 7, fuelAmountTons: 150, burnTimeSEC: 153),
            secondStage: SecondStage(reusable: true, engines: 3, fuelAmountTons: 40, burnTimeSEC: 504),
            landingLegs: LandingLegs(number: 6, material: "carbon fiber"),
            name: "Medium size rocket 2",
            type: "Medium size rocket",
            active: true,
            firstFlight: firstFlight,
            country: "USA",
            company: "SpaceX",
            wikipedia: "wikipedia link 2",
            rocketDescription: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            id: "id2")
    }
}
