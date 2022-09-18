//
//  DetailsModel.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/16.
//

import Foundation

struct Details: Codable {
    let id: Int
    let name: String
    let image: String
    let originalName: String
    let genres: [genres]
    let platformList: [platformList]
    let released: String
    let updated: String
    let playtime: Int
    let metacritic: Int?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "name_original"
        case image = "background_image"
        case name, released, updated
        case metacritic, playtime, id
        case platformList = "platforms"
        case genres
    }
}

struct platformList: Codable {
    let platform: Platform
}

struct Platform: Codable {
    let name: String
}

struct genres: Codable {
    let name: String
}
