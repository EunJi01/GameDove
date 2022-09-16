//
//  String+Extension.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        return String(format: self.localized, with)
    }
//
//    func localized(number: Int) -> String {
//        return String(format: self.localized, number)
//    }
}
