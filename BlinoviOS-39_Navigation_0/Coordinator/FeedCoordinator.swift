//
//  FeedCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit
class FeedCoordinator: FeedBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {
        let viewModel = FeedViewModel()
        let feedViewController = FeedViewController(feedViewModel: viewModel)
        rootViewController = UINavigationController(rootViewController: feedViewController)
        return rootViewController
    }
    func showScreen() {
    }
}
