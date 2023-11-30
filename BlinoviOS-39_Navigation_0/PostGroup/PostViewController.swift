//
//  PostViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 1.10.23.
//Po

import UIKit
import StorageService
class PostViewController: UIViewController {
    var getPost: Post?
    lazy var rightButton : UIBarButtonItem = UIBarButtonItem(title: "Info", style: UIBarButtonItem.Style.plain, target: self, action: #selector(openInfo))

    override func viewDidLoad() {
        super.viewDidLoad()
        rightButton.tintColor = .black
        view.backgroundColor = .systemRed
        self.navigationItem.rightBarButtonItem = rightButton
        let post = (getPost ?? Post(title: "no Data", text: "no Data", author: "no author", description: "no", image: "no"))
        title = post.title

    }

    @objc func openInfo(){
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
}
