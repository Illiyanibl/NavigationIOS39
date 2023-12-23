//
//  PhotosViewController.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 24.10.23.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController{
    var time: Double = 0.0
    var user: User?

    let photoSource = PhotoModel.createLocalGallery()
    let imageProcessor = ImageProcessor()
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
        //filterImagesOnThread(qos: .utility, filter: .noir) // 1.2 секунды
        //filterImagesOnThread(qos: .background, filter: .noir) // 4.9 секунды
       // filterImagesOnThread(qos: .default, filter: .colorInvert) // 1 секунда
       // filterImagesOnThread(qos: .userInteractive, filter: .colorInvert) // 1 секунда
        //filterImagesOnThread(qos: .utility, filter: .colorInvert) // 1.1 секунды
        filterImagesOnThread(qos: .background, filter: .colorInvert) // 4.7 секунды

    }
    func filterImagesOnThread(qos: QualityOfService, filter: ColorFilter){
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.time = self.time + 1
        })
        imageProcessor.processImagesOnThread(sourceImages: photo ?? [UIImage()], filter: filter, qos: qos, completion: {[weak self] filtredPhoto in
            var uiFiltredPhoto: [UIImage] = []
            filtredPhoto.forEach(){ uiFiltredPhoto.append(UIImage(cgImage: $0!))}
            timer.invalidate()
            self?.photoUpdate(updatedPhoto: uiFiltredPhoto)
            DispatchQueue.main.async { self?.photoCollection.reloadData()}
            let time = self?.time ?? 0
            DispatchQueue.main.async { print(time / 10)}
        })
    }

    func photoUpdate(updatedPhoto: [UIImage]){
        photo = updatedPhoto
    }

    override func viewWillDisappear(_ animated: Bool) {
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
        (photo?.count ?? 30)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(test))
        cell.photoView.addGestureRecognizer(tap)
        cell.setupCell(photo: photo?[indexPath.item])
        return cell
    }
    @objc func test(){
        print("test")
    }

}




