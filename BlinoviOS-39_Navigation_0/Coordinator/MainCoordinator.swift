//
//  MainCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    var rootViewController: UIViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = .systemRed
        tabBarController.tabBar.unselectedItemTintColor = .systemGray3
        return tabBarController
    }()
    var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator()

    
    func start() -> UIViewController {
        let feedViewController = feedCoordinator.start()
        feedCoordinator.parentCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 0)
        
        let profileViewController = profileCoordinator.start()
        profileCoordinator.parentCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile") , tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, profileViewController]
        
        return rootViewController
        
    }
    func moveTo(flow: AppFlow) {
        switch flow {
        case .feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        }
    }
    
    func resetToRoot() -> Self {
        feedCoordinator.resetToRoot()
        moveTo(flow: .feed)
        return self
    }
}
