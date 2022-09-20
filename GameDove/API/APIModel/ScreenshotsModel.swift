//
//  Screenshots.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/17.
//

import Foundation

struct Screenshots: Codable {
    var results: [ScreenshotsResults]
}

struct ScreenshotsResults: Codable {
    let image: String
}
