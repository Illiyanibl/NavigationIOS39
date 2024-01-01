//
//  BruteForce.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 28.12.23.
//

final class BruteForce{
    var bruteAction : ((String) -> Void)?
    let cheker = Checker.shared
    var password: String?
    func bruteForce(length: Int = 3) -> String{
        var passwordList: [String] = []
        Array(PasswordGenerator.dictionary).forEach(){element in
            passwordList.append(String(element))
        }
        for stage in 2...length {
            if self.password != nil { break}
            if stage < length {
                passwordList = generateLibrary(passwordList: passwordList)
            }
            if stage == length {
                brute(passwordList: passwordList)
            }
        }
        return password ?? ""
    }
    func generateLibrary(passwordList: [String])-> [String] {
        var newPasswordList: [String] = []
        for word in passwordList {
            Array(PasswordGenerator.dictionary).forEach(){element in
                newPasswordList.append(String(word) + String(element))
            }
        }
        return newPasswordList
    }
    func brute(passwordList: [String]) {
        var newPassword: String = ""
        for word in passwordList {
            if password != nil { break}
            Array(PasswordGenerator.dictionary).forEach(){element in
                newPassword = (String(word) + String(element))
                if cheker.check(login: cheker.login, password: newPassword) {
                    password = newPassword
                    bruteAction?(newPassword)
                }
            }
        }
    }
}
