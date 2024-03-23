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

    private var feedViewModel: UsersVMOutput
    var feedAction : ((FeedVCActionCases) -> Void)?
    lazy var checkGuessButton: UIButton = {
        let button = CustomButton(title: NSLocalizedString("CheckIt", comment: ""),titleColor: .systemGray, backgroundColor: .systemGray6)
        button.layer.cornerRadius = subViewCornerRaduis
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.borderWidth = 2
        button.action = { [weak self] in
            guard let self = self else { return}
            feedViewModel.changeStateIfNeeded(word: passwordTextField.text ?? "")}
        return button
    }()



    lazy var uiLabel: UIButton = {
        let button = CustomButton(title: "", titleColor: .white, backgroundColor: .black)
        button.layer.cornerRadius = subViewCornerRaduis
        return button
    }()


    lazy var passwordTextField: UITextField = {
        let text = UITextField()
        text.layer.cornerRadius = subViewCornerRaduis
        text.indent(size: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.borderColor = UIColor.systemFill.cgColor
        text.layer.borderWidth = 2
        return text
    }()

    let showPostButtonCornerRadius: CGFloat = 20

    lazy var showPostButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Post", comment: ""), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = showPostButtonCornerRadius
        button.addTarget(nil, action: #selector(showPostButtonPressed), for: .touchUpInside)
        return button
    }()

    lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Map", comment: ""), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.systemFill.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = showPostButtonCornerRadius
        button.addTarget(nil, action: #selector(showMap), for: .touchUpInside)
        return button
    }()

    @objc func showPostButtonPressed() {
        let post = Post(title: "Заголовок поста", text: "Текст поста", author: "", description: "", image: "")
        feedAction?(.showPost(post))
    }

    @objc func showMap() {
        feedAction?(.openMap)
    }





    init(feedViewModel: UsersVMOutput) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubView()
        setupConstraints()
    }
    private func setupView(){
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 24)]
        title = NSLocalizedString("Feed", comment: "")
        uiLabel.backgroundColor = .systemBackground
        updateButton()
    }
    private func setupSubView(){
        view.addSubview(showPostButton)
        view.addSubview(checkGuessButton)
        view.addSubview(passwordTextField)
        view.addSubview(uiLabel)
        view.addSubview(mapButton)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            showPostButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            showPostButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            showPostButton.heightAnchor.constraint(equalToConstant: showPostButtonCornerRadius * 2),
            showPostButton.widthAnchor.constraint(equalToConstant:  showPostButtonCornerRadius * 8),

            mapButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mapButton.topAnchor.constraint(equalTo: showPostButton.topAnchor),
            mapButton.heightAnchor.constraint(equalTo: showPostButton.heightAnchor),
            mapButton.widthAnchor.constraint(equalTo: showPostButton.widthAnchor),

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

extension FeedViewController {
    func updateButton() {
        feedViewModel.currentState = { [weak self] state in
            guard let self else { return}
            switch state {
            case .valid :
                uiLabel.backgroundColor = .green
            case .wrong:
                uiLabel.backgroundColor = .red
            case .notCheck:
                uiLabel.backgroundColor = .red
            }
        }
    }
}
