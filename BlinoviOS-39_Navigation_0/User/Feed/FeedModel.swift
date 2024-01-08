//
//  FeedModel.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 9.12.23.
//

import Foundation

class FeedModel {
    private var secretWord: String = Checker.shared.password
    func getSecretWord() -> String{
        return secretWord
    }
}
