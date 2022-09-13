//
//  GameListModel.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

struct Games: Codable {
    let results: [GamesResults]
}

struct GamesResults: Codable {
    let name: String
    let image, released: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "background_image"
        case name, released
    }
}
