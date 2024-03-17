//
//  NetworkError.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 15.01.24.
//

import Foundation
enum NetworkError: Error {
    case custom(description: String)
    case server
    case unknown
}
