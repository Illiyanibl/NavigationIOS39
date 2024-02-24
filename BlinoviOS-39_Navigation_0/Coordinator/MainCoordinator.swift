//
//  MainCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit

class MainCoordinator: MainBaseCoordinator {
    var favoriteCoordinator: FavoriteBaseCoordinator = FavoriteCoordinator()

    var parentCoordinator: MainBaseCoordinator?
    var feedCoordinator: FeedBaseCoordinator = FeedCoordinator()
    var rootViewController: UIViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .systemRed
        tabBarController.tabBar.unselectedItemTintColor = .systemRed.withAlphaComponent(0.4)
        return tabBarController
    }()
    var profileCoordinator: ProfileBaseCoordinator = ProfileCoordinator()
    var favoriteService: IFavoriteCDService = FavoriteCDService(cdService: CoreDataService())

    
    func start() -> UIViewController {
        favoriteCoordinator.parentCoordinator = self
        let favoriteViewController  = favoriteCoordinator.start()
        favoriteViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "favorite"), tag: 2)

        feedCoordinator.parentCoordinator = self
        let feedViewController = feedCoordinator.start()
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "feed"), tag: 0)
        
        profileCoordinator.parentCoordinator = self
        let profileViewController = profileCoordinator.start()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile") , tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, profileViewController, favoriteViewController]
        
        return rootViewController
        
    }
    func moveTo(flow: AppFlow) {
        switch flow {
        case .feed:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .profile:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .favorite:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        }

    }
    
    func resetToRoot() -> Self {
        feedCoordinator.resetToRoot()
        moveTo(flow: .feed)
        return self
    }
}
