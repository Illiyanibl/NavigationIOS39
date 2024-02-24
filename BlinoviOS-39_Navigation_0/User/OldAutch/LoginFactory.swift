//
//  LoginFactory.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 3.12.23.
//

import Foundation
protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        print("LoginInsprctor Создан")
        return LoginInspector(userService: CurrentUserService(), checkerService: CheckerService())
    }
}
