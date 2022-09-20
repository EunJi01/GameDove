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
                      let version = dictionary["CFBundleShortVersionString"] as? String else { return "" } // 현재 버전
                
//                guard let url = URL(string: "http://itunes.apple.com/lookup?id=\(Settings.appleID)"),
//                      let data = try? Data(contentsOf: url),
//                      let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
//                      let results = json["results"] as? [[String: Any]],
//                      let appStoreVersion = results[0]["version"] as? String else { // 앱스토어 버전
//                    return ""
//                }
                
                print("vserion: \(version), build: ")
                
//                if version == appStoreVersion {
//                    return "최신 버전입니다"
//                }
                
                return version
            }
            
            return currentVersion
        }
    }
}
