//
//  PhotoModel.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 28.10.23.
//

import UIKit

struct PhotoModel {
    var photoName: String
    var isLocalPhoto: Bool = true
    var urlPhoto: String? = nil

    static func createLocalGallery() -> [PhotoModel] {
        var photoList: [PhotoModel] = []
        let photoName: [String] = ["photo", "photo2", "photo3", "photo4",
                                   "photo5", "photo6", "photo7", "photo8", "photo9",
                                   "photo10", "photo11", "photo12", "photo13", "photo14",
                                   "photo15", "photo16", "photo17", "photo18", "photo19", "photo20"]
        photoName.forEach() {photoList.append(PhotoModel(photoName: $0)) }
        return photoList
    }
    static func getImageFromModel(photoList: [PhotoModel]) -> [UIImage]?{
        var photoCollection: [UIImage]? = []
        photoList.forEach(){ photoCollection?.append(UIImage(named: $0.photoName) ?? UIImage())}
        return photoCollection
    }
}
