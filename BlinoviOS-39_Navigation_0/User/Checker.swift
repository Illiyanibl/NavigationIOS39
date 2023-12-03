//
//  Checker.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 3.12.23.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

final class Checker{
    
    let login: String
    let password: String
    static let checker = Checker(login: "Admin", password: "123")
    private init(login: String, password: String){
        self.login = login
        self.password = password
    }
    func check(login: String, password: String) -> Bool {
        return (self.login == login && self.password == password) ? true : false
    }
}
