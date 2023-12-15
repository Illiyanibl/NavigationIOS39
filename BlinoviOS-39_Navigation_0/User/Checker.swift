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
#if DEBUG
    static let shared = Checker(login: TestUserService().user.login, password: "123")
#else
    static let shared = Checker(login: CurrentUserService().user.login, password: "123")
#endif
    private init(login: String, password: String){
        self.login = login
        self.password = password
    }
    func check(login: String, password: String) -> Bool {
        return (self.login == login && self.password == password) ? true : false
    }
}
