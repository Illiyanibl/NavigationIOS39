//
//  UIViewExtension.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 10.10.23.
//

import UIKit

extension UIView {
    func addSubviews(_ subviesList: [UIView]) {
        subviesList.forEach(){ self.addSubview($0)}
    }
}
