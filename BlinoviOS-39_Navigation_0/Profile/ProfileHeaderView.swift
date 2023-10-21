//
//  ProfileHeaderView.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 3.10.23.
//

import UIKit
class ProfileHeaderView: UIView {

    var avatarSize: CGFloat  = 120

    lazy var avatarView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = avatarSize  / 2
        image.image = UIImage(named: "avatar")
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "View point"
        return label
    }()

    lazy var statusLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "Waiting new status"
        label.textColor = .systemGray
        return label
    }()
    lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Show status", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(nil, action: #selector(actionShowStatusButton), for: .touchUpInside)
        return button
    }()
    lazy var statusTextField: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRectMake(0, 0, 10, textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font =  UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        textField.placeholder = "Write new status!"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.leftView = leftPaddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.addTarget(nil, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()

    private var statusText: String = ""

    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
        setupConstraints()

    }
    private func setupView(){
        self.backgroundColor = .lightGray
        self.addSubviews([avatarView, nameLabel, showStatusButton, statusTextField, statusLabel])

    }
    @objc func statusTextChanged(){
        statusText = statusTextField.text ?? ""
    }

    @objc func actionShowStatusButton(){
        print(statusText)
        statusLabel.text = statusText
        statusLabel.textColor = .black

    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            avatarView.heightAnchor.constraint(equalToConstant: avatarSize),
            avatarView.widthAnchor.constraint(equalToConstant: avatarSize),
            avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),

            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 27),

            showStatusButton.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            showStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),

            statusTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            statusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -34),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.centerXAnchor.constraint(equalTo: statusTextField.centerXAnchor),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }

}
