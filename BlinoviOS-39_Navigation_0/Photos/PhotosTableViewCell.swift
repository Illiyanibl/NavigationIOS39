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

    private func createPhoto() -> UIImageView {
        lazy var  photo: UIImageView = {
            var view = UIImageView()
            view.contentMode = .scaleAspectFill
            view.layer.masksToBounds = true
            view.backgroundColor = .red
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        let photosViewController = PhotosViewController()
        UINavigationController().navigationController?.pushViewController(photosViewController, animated: true)
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
