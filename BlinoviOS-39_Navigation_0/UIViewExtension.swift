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
    static var textColor: UIColor = {
        guard #available(iOS 13.0, *) else {
            return .black
        }
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            (traitCollection.userInterfaceStyle == .dark) ? UIColor(hex: "CC9933") ?? .yellow : UIColor(hex: "333333") ?? .darkGray
        }
    }()
    static var textColorAccent: UIColor = {
        guard #available(iOS 13.0, *) else {
            return .black
        }
        return UIColor { (traitCollection: UITraitCollection) -> UIColor in
            (traitCollection.userInterfaceStyle == .dark) ? UIColor(hex: "3399FF") ?? .systemBlue : UIColor(hex: "000033") ?? .darkGray
        }
    }()

    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode :
            darkMode
        }
    }

    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        let length = hexSanitized.count

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
