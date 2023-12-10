//
//  FeedViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 26.09.23.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    let subViewCornerRaduis: CGFloat = 20

    let feedModel = FeedModel()

    lazy var checkGuessButton: UIButton = {
        let button = CustomButton(title: "Проверить", titleColor: .black, backgroundColor: .lightGray)
        button.layer.cornerRadius = subViewCornerRaduis
        button.action = { [weak self] in
            guard let self = self else { return}
            self.feedModelChecker(word: self.passwordTextField.text)}
        return button
    }()

    lazy var uiLabel: UIButton = {
        let button = CustomButton(title: "", titleColor: .white, backgroundColor: self.view.backgroundColor ?? .black)
        button.layer.cornerRadius = subViewCornerRaduis
        return button
    }()


    lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.text = "123"
        text.layer.cornerRadius = subViewCornerRaduis
        text.indent(size: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.textColor = .black
        return text
    }()

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
        let post = Post(title: "Заголовок поста", text: "Текст поста", author: "", description: "", image: "")
        let postViewController = PostViewController()
        postViewController.getPost = post
        navigationController?.pushViewController(postViewController, animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubView()
        setupConstraints()
    }
    private func setupView(){
        view.backgroundColor = .systemFill
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 24)]
        title = "Feed"
        feedModel.subscribe(self)
    }
    private func setupSubView(){
        view.addSubview(showPostButton)
        view.addSubview(checkGuessButton)
        view.addSubview(passwordTextField)
        view.addSubview(uiLabel)
    }

    private func feedModelChecker(word: String?){
        guard let word else { return}
        feedModel.check(word: word)

    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            showPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            showPostButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showPostButton.heightAnchor.constraint(equalToConstant: showPostButtonCornerRadius * 2),
            showPostButton.widthAnchor.constraint(equalToConstant:  showPostButtonCornerRadius * 8),

            checkGuessButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkGuessButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            checkGuessButton.heightAnchor.constraint(equalToConstant: subViewCornerRaduis * 2),
            checkGuessButton.widthAnchor.constraint(equalToConstant: 200),

            passwordTextField.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: checkGuessButton.topAnchor, constant: -12),
            passwordTextField.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor),

            uiLabel.leadingAnchor.constraint(equalTo: checkGuessButton.leadingAnchor),
            uiLabel.trailingAnchor.constraint(equalTo: checkGuessButton.trailingAnchor),
            uiLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 12),
            uiLabel.heightAnchor.constraint(equalTo: checkGuessButton.heightAnchor),

        ])
    }
}
extension FeedViewController: Subscriber {
    func update(subject: FeedModel) {

        switch subject.wordState {
        case .valid :
            uiLabel.backgroundColor = .green
        case .error:
            uiLabel.backgroundColor = .red
        case .wrong:
            uiLabel.backgroundColor = .red
        case .notCheck:
            uiLabel.backgroundColor = .red
        }

    }


}
