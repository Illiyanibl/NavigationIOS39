//
//  FeedModel.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 9.12.23.
//

import Foundation

enum WordState {
    case error
    case valid
    case wrong
    case notCheck
}
protocol Subscriber: AnyObject {
    func update(subject: FeedModel)
}
class FeedModel {

    var wordState: WordState = .notCheck
    private var secretWord: String = "123"
    private lazy var subscribers = [Subscriber]()

    func check(word:String) {
        guard isWord(word: word) else {
            wordState = .error
            notify()
            return
        }
        guard word == secretWord else {
            wordState = .wrong
            notify()
            return
        }
        wordState = .valid
        notify()

    }

    private func isWord (word: String) -> Bool {
        guard word.isEmpty != true else {
            return false
        }
        return true
    }

    func subscribe(_ subscriber: Subscriber) {
        subscribers.append(subscriber)
    }
    
    func clearAllSubscride(){
        subscribers.removeAll()
    }

    func notify() {
        subscribers.forEach { $0.update(subject: self) }
    }
}
