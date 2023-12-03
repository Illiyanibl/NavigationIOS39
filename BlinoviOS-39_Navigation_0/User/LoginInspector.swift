//
//  LoginInspector.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 3.12.23.
//

import Foundation
struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.checker.check(login: login, password: password)
    }
}
