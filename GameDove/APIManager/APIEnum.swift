//
//  APIError.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

enum APIQuery: String {
    case key
    case ordering
    case platforms
    case dates
    
    enum Ordering: String {
        case released
        case rating
        case metacritic
    }
    
    enum Platforms: String {
        case all = "0"
        case pc = "4"
        case ios = "3"
        case android = "21"
        case playStation5 = "187"
        case playStation4 = "18"
        case nintendoSwitch = "7"
    }
}
