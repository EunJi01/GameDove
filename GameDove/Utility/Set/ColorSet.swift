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
    
    let buttonColor: UIColor = UIColor(named: "buttonColor") ?? .systemIndigo
    let backgroundColor: UIColor = UIColor(named: "backgroundColor") ?? .white
    let objectColor: UIColor = UIColor(named: "objectColor") ?? .white
//    lazy var whiteAndBlack: UIColor = darkMode(lightColor: .white, darkColor: .black)
//    lazy var blackAndWhite: UIColor = darkMode(lightColor: .black, darkColor: .white)
    
//    private func darkMode(lightColor: UIColor, darkColor: UIColor) -> UIColor {
//        if #available(iOS 13, *) {
//            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
//                if traitCollection.userInterfaceStyle == .light {
//                    return lightColor
//                } else {
//                    return darkColor
//                }
//            }
//        } else {
//            return lightColor
//        }
//    }
}
