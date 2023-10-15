//
//  LogInViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 14.10.23.
//

import UIKit

class LogInViewController: UIViewController {

    let colorSet = UIColor(hex: "#d3d3d3")

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        return image
    }()

    private lazy var authorizationViewGroup: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var  loginText: UITextField = {
        let text = UITextField()
        text.placeholder = "Email or phone"
        text.autocapitalizationType = .none
        text.indent(size: 16)
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
   //     text.delegate = self
        return text
    }()

    private lazy var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.autocapitalizationType = .none
        text.indent(size: 16)
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
    //    text.delegate = self
        return text
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubViews()
        setupConstraints()
    }

    private func setupView(){
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }

    private func setupSubViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        authorizationViewGroup.addArrangedSubview(loginText)
        authorizationViewGroup.addArrangedSubview(separatorView)
        authorizationViewGroup.addArrangedSubview(passwordText)
       // authorizationViewGroup.addSubviews([loginText,separatorView, passwordText])
        contentView.addSubviews([logoImage, authorizationViewGroup])

    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 800),

            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            authorizationViewGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorizationViewGroup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorizationViewGroup.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            authorizationViewGroup.heightAnchor.constraint(equalToConstant: 100),

            loginText.heightAnchor.constraint(equalToConstant: 49.5),
            passwordText.heightAnchor.constraint(equalToConstant: 49.5),


        ])
    }
}
