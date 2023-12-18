//
//  LogInViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 14.10.23.
//

import UIKit

final class LogInViewController: UIViewController {
    
    var currentUserService: UserService?
    var loginDelegate: LoginViewControllerDelegate?
    
    private let colorSet = UIColor(hex: "#d3d3d3")

    var loginClick: Action?

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private let authorizationViewGroup: UIStackView = {
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
        text.delegate = self
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
        text.delegate = self
        return text
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = CustomButton(title: "Log In", titleColor: .white)
        button.setBackgroundImage(UIImage(named: "bluePixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.action = { [weak self] in
            guard let self = self else { return}
            self.pressLoginButton()
        }
        button.addTarget(nil, action: #selector(allEventsLoginButton), for: .allEvents)
        return button
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
        setupLoginButton()
        scrollView.addSubview(contentView)
#if DEBUG
        loginText.text = TestUserService().user.login
#else
        loginText.text = CurrentUserService().user.login
#endif
        passwordText.text = "123"
        authorizationViewGroup.addArrangedSubviews([
            loginText,
            separatorView,
            passwordText,
        ])
        contentView.addSubviews([logoImage, authorizationViewGroup, loginButton])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLoginButton()
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func willShowKeyboard(notification: NSNotification) {
        if let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: keyboardSize.height,
                                                                    right: 0)
        }
    }
    
    @objc private func willHideKeyboard() {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    private func pressLoginButton(){

        let loginUser = loginCheck()
        guard let loginUser else {
            authorisationLoginError()
            return
        }

        let isAuthorized = authorisationCheck(login: loginUser.login, password: passwordText.text ?? "")
        guard let isAuthorized  else { return}
        guard isAuthorized == true else {
            authorisationPasswordError()
            return
        }

        let profileViewController =  ProfileViewController()
        profileViewController.getUser(user: loginUser)
        loginButton.isEnabled = false
        self.loginClick?(profileViewController)

    }
    func loginCheck() -> User?{
#if DEBUG
        currentUserService = TestUserService()
#else
        currentUserService = CurrentUserService()
#endif
        let authorizedUser: User? = currentUserService?.getUser(login: loginText.text ?? "")
        return authorizedUser
    }
    
    func authorisationCheck(login: String, password: String) -> Bool?{
        return loginDelegate?.check(login: login, password: password)
    }
    
    private func authorisationLoginError() {
        let alert = UIAlertController(title: "Login is wrong", message: "\n Не верный login", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in }
        alert.addAction(actionOk)
        present(alert, animated: true)
    }
    private func authorisationPasswordError() {
        let alert = UIAlertController(title: "Password is wrong", message: "\n Не верный password", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in }
        alert.addAction(actionOk)
        present(alert, animated: true)
    }
    
    
    @objc private func allEventsLoginButton(){
        setupLoginButton()
    }
    
    private func setupLoginButton(){
        switch loginButton.state.rawValue {
        case 0:
            loginButton.alpha = 1
        case 1:
            loginButton.alpha = 0.8
        case 2:
            loginButton.alpha = 0.8
        case 3:
            loginButton.alpha = 0.8
        default:
            loginButton.alpha = 1
        }
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
            
            loginButton.topAnchor.constraint(equalTo: authorizationViewGroup.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
