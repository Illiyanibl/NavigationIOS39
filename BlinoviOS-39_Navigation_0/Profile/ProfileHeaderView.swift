//
//  ProfileHeaderView.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 3.10.23.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    var avatarSize: CGFloat  = 120
    var avatarTapCallBack: (() -> Void)?
    
    lazy var avatarView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = avatarSize  / 2
        image.image = UIImage(named: "avatar")
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    lazy var tapView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = avatarSize  / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label =  UILabel()
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
        setupSnepKitConstraint()
        setupGesture()
    }
    
    private func setupView(){
        self.backgroundColor = .lightGray
        self.addSubviews([tapView, nameLabel, showStatusButton, statusTextField, statusLabel])
        tapView.addSubviews([avatarView])
    }
    
    private func setupGesture(){
        let tapAvatarView = UITapGestureRecognizer(target: self, action: #selector(tapAvatarView))
        tapView.addGestureRecognizer(tapAvatarView)
    }
    
    @objc func tapAvatarView(){
        avatarTapCallBack?()
    }
    
    @objc func statusTextChanged(){
        statusText = statusTextField.text ?? ""
    }
    
    @objc func actionShowStatusButton(){
        print(statusText)
        statusLabel.text = statusText
        statusLabel.textColor = .black
    }

    private func setupSnepKitConstraint(){
        avatarView.snp.makeConstraints{ maker in
            maker.leading.equalTo(self).inset(16)
            maker.top.equalTo(self).inset(16)
            maker.height.equalTo(avatarSize)
            maker.width.equalTo(avatarSize)
        }
        tapView.snp.makeConstraints{ maker in
            maker.leading.equalTo(avatarView)
            maker.trailing.equalTo(avatarView)
            maker.top.equalTo(avatarView)
            maker.bottom.equalTo(avatarView)
        }
        nameLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(self).inset(27)
            maker.trailing.equalTo(self).inset(16)
            maker.leading.equalTo(avatarView.snp_trailingMargin).inset(-27)
        }
        showStatusButton.snp.makeConstraints{ maker in
            maker.top.equalTo(avatarView.snp_bottomMargin).inset(-16)
            maker.leading.equalTo(self).inset(16)
            maker.trailing.equalTo(self).inset(16)
            maker.height.equalTo(50)
            maker.bottom.equalTo(self).inset(16)
        }
        statusTextField.snp.makeConstraints{ maker in
            maker.leading.equalTo(nameLabel)
            maker.trailing.equalTo(nameLabel)
            maker.bottom.equalTo(showStatusButton.snp_topMargin).inset(-34)
            maker.height.equalTo(40)
        }
        statusLabel.snp.makeConstraints{ maker in
            maker.top.equalTo(nameLabel.snp_bottomMargin).inset(-8)
            maker.centerX.equalTo(statusTextField)
        }


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
