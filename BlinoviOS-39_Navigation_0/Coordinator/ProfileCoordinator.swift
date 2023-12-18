//
//  ProfileCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit

class ProfileCoordinator: ProfileBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let loginViewController = LogInViewController()
        loginViewController.loginDelegate = MyLoginFactory().makeLoginInspector()
        loginViewController.loginClick = {[weak self] in
            self?.showScreen(viewController: $0)
        }
        rootViewController = UINavigationController(rootViewController: loginViewController)
        
        return rootViewController
    }
    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }
}
