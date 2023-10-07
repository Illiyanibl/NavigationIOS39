//
//  ProfileViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.09.23.
//

import UIKit
class ProfileViewController: UIViewController {
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        title = "Profile"
    }
    override func viewWillLayoutSubviews() {
        profileHeaderView.frame = view.frame
        view.addSubview(profileHeaderView)
    }
}
