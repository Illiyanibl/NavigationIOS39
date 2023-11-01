//
//  PostTableViewCell.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 18.10.23.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var imageCell: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        let labelFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.font = labelFont
        label.textColor = .systemGray

        return label
    }()

    lazy var likesLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        return label
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
    

 /*   override func prepareForReuse() {
        super.prepareForReuse()
        imageCell.layer.contents = nil
        descriptionLabel.text = nil
        likesLabel.text = nil
        viewsLabel.text = nil
        authorLabel.text = nil
    }
  */

    func setupSell(post: Post){
        authorLabel.text = post.author
        imageCell.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: " + String(post.likes)
        viewsLabel.text = "Views: " + String(post.views)
    }

    func setupView(){}

    func setupSubView(){
        contentView.addSubviews([authorLabel, imageCell, descriptionLabel, likesLabel, viewsLabel])
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            imageCell.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageCell.heightAnchor.constraint(equalTo: imageCell.widthAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

        ])

    }

}
