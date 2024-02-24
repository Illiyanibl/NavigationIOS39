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
        holdFilter(duration: 8, qos: .utility, filter: .colorInvert)
    }
    // Применяет фильтр к текущей коллекции фото на заданный промежуток веремени после чего отменяет изменение
    func holdFilter(duration: Float, qos: QualityOfService, filter: ColorFilter ) {
        let noFiltredPhoto = self.photo
        self.filterImagesOnThread(qos: qos, filter: filter)
        var timerDuration: Float = 0.0
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] timer in
            timerDuration += 1.0
            if timerDuration >= duration {
                timer.invalidate()
                self?.photoUpdate(updatedPhoto: noFiltredPhoto ?? [])
                DispatchQueue.main.async { self?.photoCollection.reloadData()}
            }
        })
    }
    func filterImagesOnThread(qos: QualityOfService, filter: ColorFilter){
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in
            self.time = self.time + 1
        })
        imageProcessor.processImagesOnThread(sourceImages: photo ?? [UIImage()], filter: filter, qos: qos, completion: {[weak self] filtredPhoto in
            timer.invalidate()
            var uiFiltredPhoto: [UIImage] = []
            filtredPhoto.forEach(){ uiFiltredPhoto.append(UIImage(cgImage: $0!))}
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




