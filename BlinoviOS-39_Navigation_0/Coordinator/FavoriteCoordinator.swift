//
//  FavoriteCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 22.02.24.
//

import UIKit
import StorageService

enum FavoriteActionCases {
    case showPost(Post)
}

class FavoriteCoordinator: FavoriteBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()
    func start() -> UIViewController {

    //    let postViewController = PostViewController()
        let favoriteViewController = FavoriteView(favoriteService: parentCoordinator?.favoriteService)
        rootViewController = UINavigationController(rootViewController: favoriteViewController)
        return rootViewController
    }
    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }
}
