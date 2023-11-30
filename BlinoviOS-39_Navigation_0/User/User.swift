//
//  User.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.11.23.
//

import UIKit

protocol UserService {
    func getUser(login: String) -> User?
}

class User {
    let login: String
    var fullName: String
    var avatar: UIImage
    var status: String

    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    static func newUser() -> User{
        let user = User(login: "Admin", fullName: "Friendly interface", avatar: UIImage(named: "user") ?? UIImage(), status: "i'll be back")
        return user
    }
    static func testUser() -> User{
        let user = User(login: "Test", fullName: "Test Name", avatar: UIImage(named: "test") ?? UIImage(), status: "Test Status")
        return user
    }
}
class TestUserService: UserService {
    let user: User
    init() {
        self.user = User.testUser()
    }
    func getUser(login: String) -> User? {
        guard user.login == login else { return nil}
        return user
    }

}

class CurrentUserService: UserService {
    let user: User
    init() {
        self.user = User.newUser()
    }
    func getUser(login: String) -> User? {
        guard user.login == login else { return nil}
        return user
    }


}
