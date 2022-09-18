//
//  DetailsEnum.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import Foundation

enum DetailsItem: CaseIterable {
    case originalName
    case genres
    case platformList
    case released
    case updated
    case playtime
    case metacritic
    
    func title() -> String {
        switch self {
        case .originalName:
            return LocalizationKey.originalName.localized
        case .genres:
            return LocalizationKey.genres.localized
        case .platformList:
            return LocalizationKey.platforms.localized
        case .released:
            return LocalizationKey.released.localized
        case .updated:
            return LocalizationKey.updated.localized
        case .playtime:
            return LocalizationKey.playtime.localized
        case .metacritic:
            return LocalizationKey.metascore.localized
        }
    }
    
    func itemData(details: Details) -> String {
        switch self {
        case .originalName:
            return details.originalName
        case .genres:
            // MARK: 배열 데이터 스트링 변환
            return ""
        case .platformList:
            // MARK: 배열 데이터 스트링 변환
            return ""
        case .released:
            return details.released
        case .updated:
            return details.updated
        case .playtime:
            return "\(details.playtime)"
        case .metacritic:
            guard let metascore = details.metacritic else { return "" }
            return "\(metascore)"
        }
    }
}
