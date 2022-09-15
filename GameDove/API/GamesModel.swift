//
//  GameListModel.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

struct Game: Codable {
    var results: [GameResults]
}
// MARK: 굳이 Game을 통해 접근하지 않아도 되는지 개선해보기
struct GameResults: Codable {
    let name: String
    let image, released: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case image = "background_image"
        case name, released, id
    }
}
