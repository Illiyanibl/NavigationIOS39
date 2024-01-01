//
//  PasswordGenerator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 28.12.23.
//

import Foundation


final class PasswordGenerator {
    static let dictionary: String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static func generatePassword(length: Int) -> String {
        var password = ""
        (1...length).forEach(){_ in 
            password += String(dictionary.randomElement() ?? "0")
        }
        return password
    }
}
