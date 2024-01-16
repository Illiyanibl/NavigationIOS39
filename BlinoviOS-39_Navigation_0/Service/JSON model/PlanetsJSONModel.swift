//
//  PlanetsJSONModel.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 15.01.24.
//

import Foundation
struct PlanetsJSONModel: Decodable {
    let name: String
    var rotationPeriod: String
    var orbitalPeriod: Int?
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    var surfaceWater: String
    var population: String
    let residents : [String]
    let films : [String]
    let created : String
    var edited : String
    let url : String

    enum PlanetCodingKeys: String, CodingKey {
        case name, rotationPeriod, orbitalPeriod, diameter, climate, gravity,terrain, surfaceWater, population, residents, films, created, edited, url
    }
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: PlanetCodingKeys.self)

        let orbitalPeriodString = try container.decode(String.self, forKey: .orbitalPeriod)

        orbitalPeriod = Int(orbitalPeriodString)
        name = try container.decode(String.self, forKey: .name)
        rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
        diameter = try container.decode(String.self, forKey: .diameter)
        climate = try container.decode(String.self, forKey: .climate)
        gravity = try container.decode(String.self, forKey: .gravity)
        terrain = try container.decode(String.self, forKey: .terrain)
        surfaceWater = try container.decode(String.self, forKey: .surfaceWater)
        population = try container.decode(String.self, forKey: .population)
        residents = try container.decode([String].self, forKey: .residents)
        films = try container.decode([String].self, forKey: .films)
        created = try container.decode(String.self, forKey: .created)
        edited = try container.decode(String.self, forKey: .edited)
        url = try container.decode(String.self, forKey: .url)
    }
}
