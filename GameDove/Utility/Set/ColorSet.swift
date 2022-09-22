//
//  ColorSet.swift
//  MemoProject
//
//  Created by 황은지 on 2022/08/31.
//

import UIKit

final class ColorSet {
    static let shared = ColorSet()
    private init() {}
    
    let button: UIColor = UIColor(named: "buttonColor") ?? .blue
    let background: UIColor = UIColor(named: "backgroundColor") ?? .white
    let objectBack: UIColor = UIColor(named: "objectColor") ?? .white
    let clearBlack: UIColor = UIColor(named: "clearBlack") ?? .lightGray

    lazy var gray: UIColor = darkMode(lightColor: .darkGray, darkColor: .lightGray)
    lazy var buttonActive: UIColor = darkMode(lightColor: .systemIndigo, darkColor: .cyan)
    
    private func darkMode(lightColor: UIColor, darkColor: UIColor) -> UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return lightColor
                } else {
                    return darkColor
                }
            }
        } else {
            return lightColor
        }
    }
}
