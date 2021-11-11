//
//  Rocket.swift
//  SpaceX_swiftui_combine_tca
//
//  Created by alex on 08.11.2021.
//

import Foundation

typealias Rockets = [Rocket]

// MARK: - Rocket
struct Rocket: Codable, Identifiable, Equatable {
//    let height, diameter: Diameter
//    let mass: Mass
//    let firstStage: FirstStage
//    let secondStage: SecondStage
//    let engines: Engines
//    let landingLegs: LandingLegs
//    let payloadWeights: [PayloadWeight]
//    let flickrImages: [String]
    let name, type: String
    let active: Bool
//    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight: Date
    let country, company: String
    let wikipedia: String
    let rocketDescription, id: String

    enum CodingKeys: String, CodingKey {
//        case height, diameter, mass
//        case firstStage = "first_stage"
//        case secondStage = "second_stage"
//        case engines
//        case landingLegs = "landing_legs"
//        case payloadWeights = "payload_weights"
//        case flickrImages = "flickr_images"
        case name, type, active//, stages, boosters
//        case costPerLaunch = "cost_per_launch"
//        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, wikipedia
        case rocketDescription = "description"
        case id
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters, feet: Double?
}

// MARK: - Engines
struct Engines: Codable {
    //let isp: ISP
    //let thrustSeaLevel, thrustVacuum: Thrust
    let number: Int
    let type, version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1, propellant2: String
    let thrustToWeight: Double

    enum CodingKeys: String, CodingKey {
        //case isp
        //case thrustSeaLevel = "thrust_sea_level"
        //case thrustVacuum = "thrust_vacuum"
        case number, type, version, layout
        case engineLossMax = "engine_loss_max"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}

// MARK: - ISP
//struct ISP: Codable {
//    let seaLevel, vacuum: Int
//
//    enum CodingKeys: String, CodingKey {
//        case seaLevel = "sea_level"
//        case vacuum
//    }
//}

// MARK: - Thrust
//struct Thrust: Codable {
//    let kN, lbf: Int
//}

// MARK: - FirstStage
struct FirstStage: Codable {
    //let thrustSeaLevel, thrustVacuum: Thrust
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        //case thrustSeaLevel = "thrust_sea_level"
//        case thrustVacuum = "thrust_vacuum"
        case reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - LandingLegs
struct LandingLegs: Codable {
    let number: Int
    let material: String?
}

// MARK: - Mass
struct Mass: Codable {
    let kg, lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id, name: String
    let kg, lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable {
    //let thrust: Thrust
//    let payloads: Payloads
    let reusable: Bool
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        //case thrust, payloads
        case reusable, engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - Payloads
//struct Payloads: Codable {
//    let compositeFairing: CompositeFairing
//    let option1: String
//
//    enum CodingKeys: String, CodingKey {
//        case compositeFairing = "composite_fairing"
//        case option1 = "option_1"
//    }
//}

// MARK: - CompositeFairing
struct CompositeFairing: Codable {
    let height, diameter: Diameter
}

// MARK: Mock
extension Rocket {
    static var mockRocket1: Rocket {
        let firstFlightString = "2018-02-05"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstFlight = dateFormatter.date(from: firstFlightString) else { fatalError() }
        return Rocket(
            name: "Big rocket 123",
            type: "Big rocket",
            active: true,
            firstFlight: firstFlight,
            country: "USA",
            company: "SpaceX",
            wikipedia: "wikipedia link 1",
            rocketDescription: "description description description",
            id: "id1")
    }
    
    static var mockRocket2: Rocket {
        let firstFlightString = "2020-05-02"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstFlight = dateFormatter.date(from: firstFlightString) else { fatalError() }
        return Rocket(
            name: "Medium size rocket 2",
            type: "Medium size rocket",
            active: true,
            firstFlight: firstFlight,
            country: "USA",
            company: "SpaceX",
            wikipedia: "wikipedia link 2",
            rocketDescription: "description descrip tion desc ription cription descrip tion",
            id: "id2")
    }
}
