//
//  PhotosViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 24.10.23.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController, ImageLibrarySubscriber {
    var user: User?

    let photoSource = PhotoModel.createLocalGallery()
    let imagePublisherFacade = ImagePublisherFacade()
    var allCell: [PhotosCollectionViewCell] = []
    lazy var photo = PhotoModel.getImageFromModel(photoList: photoSource)
    
    
    
    lazy var photoCollection: UICollectionView = {
        let loyut = UICollectionViewFlowLayout()
        loyut.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: loyut)
        collection.dataSource = self
        collection.delegate = self
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collection
    }()
    // MARK: - Setup View
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
        view.backgroundColor = .white
        view.addSubviews([photoCollection])
        navigationController?.navigationBar.isHidden = false
        setupConstraints()
        subscribeImagePublisherFacade()
    }
    private func subscribeImagePublisherFacade(){
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: photoSource.count - 2, userImages: photo)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        imagePublisherFacade.removeSubscription(for: self)
    }
    func getUser(user: User){
        self.user = user
    }
    // MARK: - Setup Constraints
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            photoCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
// MARK: - Extension
extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var inset: CGFloat  { return 8}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 4) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(test))
        cell.photoView.addGestureRecognizer(tap)
        allCell.append(cell)
        print(allCell.count)
        return cell
    }
    @objc func test(){
        print("test")
    }
    func receive(images: [UIImage]){
        allCell[images.count - 1].setupCell(photo: images[images.count - 1])
        
    }
}




