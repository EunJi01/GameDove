//
//  GameListModel.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

struct Game: Codable {
    let results: [GameResults]
}

struct GameResults: Codable {
    let name: String
    let image, released: String?
    let id: Int
    let metascore: Int?
    
    enum CodingKeys: String, CodingKey {
        case image = "background_image"
        case metascore = "metacritic"
        case name, released, id
    }
}
