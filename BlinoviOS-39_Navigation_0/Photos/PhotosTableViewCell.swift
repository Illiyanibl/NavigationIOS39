//
//  PhotosTableViewCell.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 24.10.23.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {

    private let photos = PhotoModel.createLocalGallery()

    private var photoCollection: [UIImageView] = []

    var callBackTapArrow: ((ProfileVCActionCases) -> Void)?

    private func createPhoto() -> UIImageView {
        lazy var  photo: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 6
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        return photo
    }
    private let photoViewGroup: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.clipsToBounds = true
        stackView.spacing = 8
        return stackView
    }()

    private let endView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        return label
    }()

    lazy var photosButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapPhotosButton), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "arrow"), for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupSubView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapPhotosButton(){
        callBackTapArrow?(.photosCollectionClick)
    }

    private func setupView(){
        self.backgroundColor = .white
    }

    private func setupSubView(){
        photoCollection = { [self.createPhoto(), self.createPhoto(), self.createPhoto(), self.createPhoto()]}()
        photoCollection.enumerated().forEach(){ index, value in value.image =  UIImage(named: photos[index].photoName) }
        photoViewGroup.addArrangedSubviews(photoCollection + [endView])
        contentView.addSubviews([title, photosButton, photoViewGroup])
    }

    private func setupGesture(){
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            photosButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            photosButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            photoViewGroup.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            photoViewGroup.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photoViewGroup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoViewGroup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            photoCollection[0].heightAnchor.constraint(equalTo: photoViewGroup.widthAnchor, multiplier: 0.226),
            photoCollection[0].widthAnchor.constraint(equalTo: photoCollection[0].heightAnchor),

            photoCollection[1].widthAnchor.constraint(equalTo: photoCollection[0].widthAnchor),
            photoCollection[2].widthAnchor.constraint(equalTo: photoCollection[0].widthAnchor),
            photoCollection[3].widthAnchor.constraint(equalTo: photoCollection[0].widthAnchor),
        ])
    }
}
