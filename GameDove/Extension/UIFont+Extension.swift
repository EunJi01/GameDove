//
//  UIFont+Extension.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/28.
//

import UIKit

extension UIFont {
    func pretendardRegularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    func pretendardMediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Medium", size: size) ?? .systemFont(ofSize: 10)
    }
    
    func pretendardBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Pretendard-Bold", size: size) ?? .systemFont(ofSize: 10)
    }
}
