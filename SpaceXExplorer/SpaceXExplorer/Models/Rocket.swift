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
    let height: Diameter
    let diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
//    let engines: Engines
    let landingLegs: LandingLegs
//    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let type: String
    let active: Bool
//    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight: Date
    let country: String
    let company: String
    let wikipedia: String
    let rocketDescription: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
//        case engines
        case landingLegs = "landing_legs"
//        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
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
struct Diameter: Codable, Equatable {
    let meters: Double?
    let feet: Double?
}

// MARK: - Engines
struct Engines: Codable {
    //let isp: ISP
    //let thrustSeaLevel: Thrust
//    let thrustVacuum: Thrust
    let number: Int
    let type: String
    let version: String
    let layout: String?
    let engineLossMax: Int?
    let propellant1: String
    let propellant2: String
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
//    let seaLevel:Int
//    let vacuum: Int
//
//    enum CodingKeys: String, CodingKey {
//        case seaLevel = "sea_level"
//        case vacuum
//    }
//}

// MARK: - Thrust
//struct Thrust: Codable {
//    let kN: Int
//    let lbf: Int
//}

// MARK: - FirstStage
struct FirstStage: Codable, Equatable {
    //let thrustSeaLevel: Thrust
//    let thrustVacuum: Thrust
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
struct LandingLegs: Codable, Equatable {
    let number: Int
    let material: String?
}

// MARK: - Mass
struct Mass: Codable, Equatable {
    let kg: Int
    let lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable ,Equatable {
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
    let height: Diameter
    let diameter: Diameter
}
