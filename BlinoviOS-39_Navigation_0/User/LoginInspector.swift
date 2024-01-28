//
//  LoginInspector.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 3.12.23.
//

import Foundation
import FirebaseAuth
protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String?, password: String?)
    func signOut()
    var authAction : ((User) -> Void)? { get set } // 
    var errorAuthAction : ((String) -> Void)? { get set }
}

final class LoginInspector: LoginViewControllerDelegate {
    let checkerService: CheckerServiceProtocol = CheckerService()
    var userService: UserService = CurrentUserService()
    var authAction : ((User) -> Void)?
    var errorAuthAction : ((String) -> Void)?
    func check(login: String?, password: String?) {
        guard let login else {
            return
        }
        guard let password else {
            return
        }
        guard requirementsVerification(login: login, password: password) else {
            return
        }
        //!тут перестает работать если сделать ссылку слабой
        checkerService.checkCredentials(login: login, password: password, email: nil){ authResult in //[weak self]
            switch authResult {
            case .success(_):
                self.userService.newUser(login: login)
                let authUser = self.userService.getUser(login: login)
                guard let authUser else { return}
                print("Найден \(authUser.login)")
                self.authAction?(authUser)

            case let .failure(authError):
                self.registration(login: login, password: password, authError: authError.localizedDescription + "\n")
            }
        }
    }
    func signOut(){
        checkerService.signOut()
    }
    func registration(login: String, password: String, authError: String){
        checkerService.signUp(login: login, password: password, email: nil) { error in
            guard let error else {
                self.errorAuthAction?("Аккаунт зарегистрирован!")
                return
            }
            self.errorAuthAction?(authError + error.localizedDescription)
        }
    }


    func requirementsVerification(login: String, password: String) -> Bool{
        let dictionary: String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        guard login.count > 2 else {
            errorAuthAction?("Логин не должен быть короче 3 символов")
            return false
        }
        guard password.count > 5 else {
            errorAuthAction?("Пароль не должен быть короче 6 символов")
            return false
        }
        var loginIsLiterals = true
        login.forEach(){ if dictionary.contains(String($0)) {} else { loginIsLiterals = false}}
        guard loginIsLiterals else {
            errorAuthAction?("Логин может содержать только буквы и цифры")
            return false
        }
        return true
    }
}
