//
//  CustomButton.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 9.12.23.
//

import UIKit
class CustomButton: UIButton {
    typealias Action = () -> Void
    var action: Action?

    init(title: String, titleColor: UIColor = .white, backgroundColor: UIColor = .black, translatesAMIC: Bool = false) {
        super.init(frame: .null)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)

        self.backgroundColor = backgroundColor
        self.translatesAutoresizingMaskIntoConstraints = translatesAMIC
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped(){
        action?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
