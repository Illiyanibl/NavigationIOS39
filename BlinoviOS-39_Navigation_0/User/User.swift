//
//  User.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.11.23.
//

import UIKit

protocol UserService {
    var listUser: [User] { get set }
    func getUser(login: String) -> User?
    mutating func newUser(login: String)
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
    static func newUser(login: String) -> User{
        let user = User(login: login, fullName: "Friendly \(login)", avatar: UIImage(named: "user") ?? UIImage(), status: "I' m \(login)")
        return user
    }
    static func testUser() -> User{
        let user = User(login: "Test", fullName: "Test Name", avatar: UIImage(named: "test") ?? UIImage(), status: "Test Status")
        return user
    }
}
class TestUserService: UserService {
    var listUser: [User]
    init() {
        self.listUser = []
    }
}

class CurrentUserService: UserService {
    var listUser: [User]
    init() {
        self.listUser = []
    }
}
extension UserService {
    func getUser(login: String) -> User? {
        var findUser: User?
        listUser.forEach(){ if login == $0.login { findUser = $0 }}
        return findUser
    }
    mutating func newUser(login: String) {
        listUser.append(User.newUser(login: login))
    }
}
