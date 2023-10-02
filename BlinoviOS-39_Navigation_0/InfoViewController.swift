//
//  InfoViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 1.10.23.
//

import UIKit
class InfoViewController: UIViewController {
    let alertButtonCornerRadius: CGFloat = 20
    lazy var alertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alert", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = alertButtonCornerRadius
        button.addTarget(nil, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0.88
        view.addSubview(alertButton)
        setupConstraints()
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: alertButtonCornerRadius * 2),
            alertButton.widthAnchor.constraint(equalToConstant:  alertButtonCornerRadius * 8),
        ])}

    @objc func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "Информация", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in print("Pressed Cancel")}
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in print("Pressed Ok")}
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        present(alert, animated: false)
    }
}
