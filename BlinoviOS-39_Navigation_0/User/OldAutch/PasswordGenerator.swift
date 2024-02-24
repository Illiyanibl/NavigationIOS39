//
//  PasswordGenerator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 28.12.23.
//

import Foundation


final class PasswordGenerator {
    static let dictionary: String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let dictionaryNumbers: String = "0123456789"
    static let randomGenerator = [1,2,3,4,5]
    static func generatePassword(length: Int) -> String {
        var password = ""
        (1...length).forEach(){_ in 
            if randomGenerator.randomElement() ?? 0 != 4 {
                password += String(dictionary.randomElement() ?? "0")
            } else {
                password += String(dictionaryNumbers.randomElement() ?? "0")
            }
        }
        return password
    }
}
