//
//  FeedCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit
import StorageService

enum FeedVCActionCases {
    case showPost(Post)
}
class FeedCoordinator: FeedBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        
        let postViewController = PostViewController()
        
        let viewModel = FeedViewModel()
        let feedViewController = FeedViewController(feedViewModel: viewModel)
        
        feedViewController.feedAction = { [weak self] in
            switch $0 {
            case .showPost(let post) :
                postViewController.getPost = post
                self?.showScreen(viewController: postViewController)
            }
        }
        
        rootViewController = UINavigationController(rootViewController: feedViewController)
        return rootViewController
    }
    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }
}
