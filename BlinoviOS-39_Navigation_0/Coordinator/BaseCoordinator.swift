//
//  BaseCoordinator.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 17.12.23.
//

import UIKit

typealias Action = ((_ : UIViewController) -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}
protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }

    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}

enum AppFlow {
    case feed
    case profile
}

protocol FeedBaseCoordinator: Coordinator {
    func showScreen()
}

protocol ProfileBaseCoordinator: Coordinator {
    func showScreen(viewController : UIViewController)
}

protocol MainBaseCoordinator: Coordinator {
    var feedCoordinator: FeedBaseCoordinator { get }
    var profileCoordinator: ProfileBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}

