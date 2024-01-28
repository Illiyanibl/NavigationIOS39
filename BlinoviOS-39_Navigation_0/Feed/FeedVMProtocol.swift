//
//  FeedVMProtocol.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 12.12.23.
//

import Foundation
protocol UsersVMOutput {
    var state: WordState { get set }
    var currentState: ((WordState) -> Void)? { get set }
    func changeStateIfNeeded(word: String)
}

enum WordState {
    case valid
    case wrong
    case notCheck
}
