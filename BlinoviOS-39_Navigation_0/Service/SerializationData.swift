//
//  SerializationData.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 14.01.24.
//

import Foundation

struct SerializationData {
    static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    static func serialization(data: Data) -> [String: Any]? {
        let  object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return object
    }
    static func planetDecoder(data: Data) -> PlanetsJSONModel? {
        let object =  try? self.decoder.decode(PlanetsJSONModel.self, from: data)
        return object
    }
}
