//
//  PhotosCollectionViewCell.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 24.10.23.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSubView(){
        contentView.addSubviews([photoView])
        
    }
    func setupCell(photo: PhotoModel){
        photoView.image = UIImage(named: photo.photoName)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
extension PhotosCollectionViewCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}
