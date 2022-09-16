//
//  DetailsModel.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/16.
//

import Foundation

struct Details: Codable {
    let name: String
    let originalName: String
    let metacritic: Int
    let released: String
    let updated: String
    let image: String
    let playtime: Int
    var platformList: [PlatformList]
    var genres: [genres]
    
    enum CodingKeys: String, CodingKey {
        case originalName = "name_original"
        case image = "background_image"
        case name, released, updated
        case metacritic, playtime
        case platformList = "platforms"
        case genres
    }
}

struct PlatformList: Codable {
    var platform: [Platform]
}

struct Platform: Codable {
    let name: String
}

struct genres: Codable {
    let name: String
}
