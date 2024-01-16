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
enum PostVCActionCases {
    case openInfo
}
class FeedCoordinator: FeedBaseCoordinator {
    var parentCoordinator: MainBaseCoordinator?
    lazy var rootViewController: UIViewController = UIViewController()

    func start() -> UIViewController {

        let postViewController = PostViewController()
        let infoViewController = InfoViewController()

        let viewModel = FeedViewModel()
        let feedViewController = FeedViewController(feedViewModel: viewModel)

        feedViewController.feedAction = { [weak self] in
            switch $0 {
            case .showPost(let post) :
                postViewController.getPost = post
                self?.showScreen(viewController: postViewController)
            }
        }

        postViewController.postAction = { [weak self] in
            switch $0 {
            case .openInfo :
                self?.navigationRootViewController?.present(infoViewController, animated: true)
            }
        }
        

        rootViewController = UINavigationController(rootViewController: feedViewController)
        return rootViewController
    }
    func showScreen(viewController : UIViewController) {
        navigationRootViewController?.pushViewController(viewController, animated: true)
    }
}
