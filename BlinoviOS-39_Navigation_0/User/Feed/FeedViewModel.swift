//
//  FeedViewModel.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 12.12.23.
//

import Foundation

final class FeedViewModel: UsersVMOutput {
    private let model = FeedModel()
    var state: WordState = .notCheck{
        didSet {
            currentState?(state)
        }
    }

    var currentState: ((WordState) -> Void)?
    
    func changeStateIfNeeded(word: String) {
        check(word: word)
    }

    func check(word: String) {
        guard isWord(word: word) else {
            state = .error
            return
        }
        guard word == model.getSecretWord() else {
            state = .wrong
            return
        }
        state = .valid
    }
    private func isWord (word: String) -> Bool {
        guard word.isEmpty != true else {
            return false
        }
        return true
    }



    
    
}