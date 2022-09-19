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
            return LocalizationKey.title.localized
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
            let list = details.genres.map { $0.name }
            return list.reduce("") { str, i in
                list.first == i ? str + i : str + "   |   " + i
            }
        case .platformList:
            let platformList = details.platformList.map { $0.platform }
            let list = platformList.map { $0.name }
            return list.reduce("") { str, i in
                list.first == i ? str + i : str + "   |   " + i
            }
        case .released:
            return details.released
        case .updated:
            return details.updated
        case .playtime:
            return details.playtime == 0 ? LocalizationKey.noData.localized : "\(details.playtime)"
        case .metacritic:
            guard let metascore = details.metacritic else { return LocalizationKey.noData.localized }
            return "\(metascore)"
        }
    }
}
