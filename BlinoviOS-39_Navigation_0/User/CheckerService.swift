//
//  CheckerService.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 27.01.24.
//

import Foundation
import FirebaseAuth
enum EmailDomain: String {
    case main = "@application.me"
}
protocol CheckerServiceProtocol: Any {
    func checkCredentials(login: String, password: String, email: EmailDomain?, completion: @escaping (Result<Any, Error>) -> Void)
    func signUp(login: String, password: String, email: EmailDomain?, completion: @escaping (Error?) -> Void)
    func checkAuth() -> Bool
    func signOut()
}
struct CheckerService: CheckerServiceProtocol{
    func checkAuth() -> Bool  {
        if FirebaseAuth.Auth.auth().currentUser != nil { return true} else { return false}
    }

    func signOut(){
        do { try Auth.auth().signOut() }
        catch { print("Нет авторизации") }
    }

    func checkCredentials(login: String, password: String, email: EmailDomain? = EmailDomain.main, completion: @escaping (Result<Any, Error>) -> Void) {
        let userEmail  = login + (email?.rawValue ?? EmailDomain.main.rawValue)
        FirebaseAuth.Auth.auth().signIn(withEmail: userEmail, password: password){ result, error in
            print("Пробую авторизовать \(userEmail)")
            guard let result else {
                DispatchQueue.main.async {
                    completion(.failure(error.unsafelyUnwrapped))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(result.user))
            }
        }
    }

    func signUp(login: String, password: String, email: EmailDomain? = EmailDomain.main, completion: @escaping (Error?) -> Void) {
        let userEmail = login + (email?.rawValue ?? EmailDomain.main.rawValue)
        Auth.auth().createUser(withEmail: userEmail, password: password) { autchResult, autchError in
            print("Пробую зарегистрировать \(userEmail)")
            guard autchResult != nil else {
                DispatchQueue.main.async {
                    completion(autchError)
                }
                return
            }
            DispatchQueue.main.async {
                print("\(userEmail) успешно")
                completion(nil)
            }
        }
    }
}
