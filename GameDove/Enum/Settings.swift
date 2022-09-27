//
//  SettingsEnum.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import Foundation

enum Settings: CaseIterable {
    
    static let appleID = 1645004525
    
    case mainPlatform
    case contact
    case review
    case api
    case version
    
    func title() -> String {
        switch self {
        case .mainPlatform:
            return LocalizationKey.mainPlatform.localized
        case .contact:
            return LocalizationKey.contact.localized
        case .review:
            return LocalizationKey.review.localized
        case .api:
            return "API"
        case .version:
            return LocalizationKey.version.localized
        }
    }
    
    func rightDetail() -> String {
        switch self {
        case .mainPlatform:
            guard let platform = MainPlatformRepository().fetch().first?.title else { return "" }
            return platform
        case .contact:
            return ""
        case .review:
            return ""
        case .api:
            return "RAWG"
        case .version:
            var currentVersion: String {
                guard let dictionary = Bundle.main.infoDictionary,
                      let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
                return version
            }
            return currentVersion
        }
    }
}
