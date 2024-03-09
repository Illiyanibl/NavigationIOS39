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

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.text = "Waitin data"
        return label
    }()

    lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.text = "Waitin data"
        return label
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0.88
        view.addSubview(alertButton)
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        setupConstraints()
        getUserJSONModel()
        getPlanetJSONModel()

    }
    private func getUserJSONModel(){
        let userURL: String = "https://jsonplaceholder.typicode.com/todos/100"
        NetworkService.requestURL(for: userURL){ [weak self] userData in
            switch userData {
            case let .success(userData):
                let userJSONModel = SerializationData.serialization(data: userData)
                guard let userJSONModel else { return }
                let title = userJSONModel["title"] as? String
                self?.titleLabel.text = title
            case .failure:
                break
            }
        }
    }

    private func getPlanetJSONModel(){
        let planetURL: String = "https://swapi.dev/api/planets/1"
        NetworkService.requestURL(for: planetURL){ [weak self] planetData in
            switch planetData {
            case let .success(planetData):
                let planetJSONModel = SerializationData.planetDecoder(data: planetData)
                guard let planetJSONModel else {return }
                guard let orbitalPeriod = planetJSONModel.orbitalPeriod else {
                    self?.orbitalPeriodLabel.text = "Model error"
                    return
                }
                self?.orbitalPeriodLabel.text = "Orbital Period is \(orbitalPeriod)"

            case .failure:
                break
            }

        }
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            alertButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: alertButtonCornerRadius * 2),
            alertButton.widthAnchor.constraint(equalToConstant:  alertButtonCornerRadius * 8),

            titleLabel.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: alertButton.centerXAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: alertButton.centerXAnchor),

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
