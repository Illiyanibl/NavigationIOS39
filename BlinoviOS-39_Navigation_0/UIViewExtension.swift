//
//  UIViewExtension.swift
//  BlinoviOS-39_Navigation_0
//
//  Created by Illya Blinov on 10.10.23.
//

import UIKit

extension String {
    var localize: String {
        NSLocalizedString(self, comment: "")
    }
    var multiLocalize: String {
        NSLocalizedString(self, tableName: "loacalize", comment: "")
    }
}


extension UIView {
    static var identifier: String {
        String(describing: self)
    }

    func addSubviews(_ subviesList: [UIView]) {
        subviesList.forEach(){
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)}
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviesList: [UIView]) {
        subviesList.forEach(){ self.addArrangedSubview($0)}
    }
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
