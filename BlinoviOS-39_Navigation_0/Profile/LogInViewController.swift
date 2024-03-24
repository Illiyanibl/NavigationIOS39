//
//  LogInViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 14.10.23.
//
import UIKit


final class LogInViewController: UIViewController {
    private var delegate: LoginViewControllerDelegate?
    var loginAction : ((LoginVCActionCases) -> Void)?
    init(delegate: LoginViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private let colorSet = UIColor(hex: "#d3d3d3")
    
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
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = .blue
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
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
        text.textColor = UIColor.textColorAccent
        text.placeholder = NSLocalizedString("Login", comment: "")
        text.text = "admin"
        text.autocapitalizationType = .none
        text.indent(size: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        return text
    }()
    
    private lazy var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = NSLocalizedString("Password", comment: "")
        text.textColor = UIColor.textColorAccent
        text.text = "123456"
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
        let button = CustomButton(title: NSLocalizedString("LogIn", comment: ""), titleColor: .white)
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
    
    private lazy var bruteButton: UIButton = {
        let button = CustomButton(title: NSLocalizedString("ResearchPassword", comment: ""), titleColor: .white)
        button.setBackgroundImage(UIImage(named: "bluePixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.action = { [weak self] in
            guard let self = self else { return}
            self.setupPassword()
        }
        button.isEnabled = false
        button.isHidden = true
        button.addTarget(nil, action: #selector(allEventsLoginButton), for: .allEvents)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubViews()
        setupConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.signOut()
    }
    
    private func setupView(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupSubViews(){
        view.addSubview(scrollView)
        setupLoginButton()
        scrollView.addSubview(contentView)
        authorizationViewGroup.addArrangedSubviews([
            loginText,
            separatorView,
            passwordText,
        ])
        contentView.addSubviews([logoImage, authorizationViewGroup, activityIndicator, loginButton, bruteButton])
        
    }
    private func setupPassword(){
        bruteButton.isEnabled = false
        activityIndicator.startAnimating()
        let dqBruteQueue = DispatchQueue(label: "bruteQueue", qos: .background)
        let brute = BruteForce()
        dqBruteQueue.async {
            let password = brute.bruteForce(length: 5)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.passwordText.text = password
                self.passwordText.isSecureTextEntry = false
                self.activityIndicator.stopAnimating()
                self.bruteButton.isEnabled = true
            }
        }
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
        loginCheck()
    }
    func loginCheck(){
        
        activityIndicator.startAnimating()
        delegate?.errorAuthAction = {[weak self] errorDescription in
            self?.activityIndicator.stopAnimating()
            self?.authorisationError(description: errorDescription)
        }
        delegate?.authAction = {[weak self] user in
            self?.activityIndicator.stopAnimating()
            self?.loginAction?(.autorisation(user))
        }
        delegate?.check(login: loginText.text, password: passwordText.text)
    }
    
    private func authorisationError(description: String) {
        let alert = UIAlertController(title: NSLocalizedString("AuthorisationError", comment: ""), message: description, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { _ in }
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
            loginButton.alpha = 1
        case 2:
            loginButton.alpha = 1
        case 3:
            loginButton.alpha = 1
        default:
            loginButton.alpha = 1
        }
    }
    
    private func setupConstraints(){
        var bruteButtonHeight: CGFloat = 50
        var btuteButtonTopAnchor: CGFloat = 16
        if bruteButton.isHidden == true {
            bruteButtonHeight = 0
            btuteButtonTopAnchor = 0
        }
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
            
            activityIndicator.centerXAnchor.constraint(equalTo: passwordText.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: passwordText.centerYAnchor),
            
            authorizationViewGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorizationViewGroup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorizationViewGroup.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            authorizationViewGroup.heightAnchor.constraint(equalToConstant: 100),
            
            loginText.heightAnchor.constraint(equalToConstant: 49.5),
            passwordText.heightAnchor.constraint(equalToConstant: 49.5),
            
            bruteButton.topAnchor.constraint(equalTo: authorizationViewGroup.bottomAnchor, constant: btuteButtonTopAnchor),
            bruteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bruteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bruteButton.heightAnchor.constraint(equalToConstant: bruteButtonHeight),
            
            loginButton.topAnchor.constraint(equalTo: bruteButton.bottomAnchor, constant: 16),
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
