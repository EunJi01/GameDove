//
//  APIError.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import Foundation

enum APIQuery: String {
    case key
    case ordering
    case platforms
    case dates
    case pageSize = "page_size"
    case search
    case page
    
    enum Ordering: String {
        case released = "-released"
        case metacritic = "-metacritic"
        case upcoming = "released"
    }
    
    enum Platforms: String, CaseIterable {
        case nintendoSwitch = "7"
        case playStation5 = "187"
        case playStation4 = "18"
        case pc = "4"
        case ios = "3"
        case android = "21"

        static func title(platform: APIQuery.Platforms) -> String {
            switch platform {
            case .pc:
                return "PC"
            case .ios:
                return "iOS"
            case .android:
                return "Android"
            case .playStation5:
                return "PS5"
            case .playStation4:
                return "PS4"
            case .nintendoSwitch:
                return "Switch"
            }
        }
        
//        static func allPlatforms() -> String {
//            let platformList = Platforms.allCases.map { $0.rawValue }
//            return platformList[1...].reduce("") { str, i in str + "," + i}
//        }
    }
    
    static func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
