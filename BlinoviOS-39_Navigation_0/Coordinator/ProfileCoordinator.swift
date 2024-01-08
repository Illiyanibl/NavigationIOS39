//
//  ProfileCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit

enum ProfileVCActionCases {
    case photosCollectionClick
}

enum LoginVCActionCases {
    case autorization(User)
    case test(User)
}


class ProfileCoordinator: ProfileBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()
    
    
    func start() -> UIViewController {
        let loginViewController = LogInViewController()
        let profileViewController =  ProfileViewController()
        let photosViewController = PhotosViewController()
        loginViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
        
        loginViewController.loginAction = { [weak self] in
            switch $0 {
            case .autorization(let user):
                profileViewController.getUser(user: user)
                self?.showScreen(viewController: profileViewController)
            case .test(let user):
                print(user.login, user.fullName)
                print("Тест пользователя - ОК")
            }
        }
        
        profileViewController.profileAction = {  [weak self] in
            switch $0 {
            case .photosCollectionClick :
                self?.showScreen(viewController: photosViewController)
            }
        }
        
        rootViewController = UINavigationController(rootViewController: loginViewController)
        return rootViewController
    }
    
    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }
}
