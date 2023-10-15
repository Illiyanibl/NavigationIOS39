//
//  FeedViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.09.23.
//

import UIKit
class FeedViewController: UIViewController {

    let showPostButtonCornerRadius: CGFloat = 20
    lazy var showPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)

        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = showPostButtonCornerRadius
        button.addTarget(nil, action: #selector(showPostButtonPressed), for: .touchUpInside)
        return button
    }()

    @objc func showPostButtonPressed() {
        let post = Post(title: "Заголовок поста", text: "Текст поста")
        let postViewController = PostViewController()
        postViewController.getPost = post
        navigationController?.pushViewController(postViewController, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemFill
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 24)]
        title = "Feed"
        view.addSubview(showPostButton)
        setupConstraints()
    }
    
        private func setupConstraints(){
            NSLayoutConstraint.activate([
                showPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                showPostButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                showPostButton.heightAnchor.constraint(equalToConstant: showPostButtonCornerRadius * 2),
                showPostButton.widthAnchor.constraint(equalToConstant:  showPostButtonCornerRadius * 8)
            ])}
    }
