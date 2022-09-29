//
//  MainPlatformRepository.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/20.
//

import Foundation
import RealmSwift

protocol SettingsRepositoryType {
    func fetch() -> Results<MainSettings>!
    func updateItem(id: String, title: String)
}

class MainPlatformRepository: SettingsRepositoryType {
    let localRealm = try! Realm()
    
    func fetch() -> Results<MainSettings>! {
        return localRealm.objects(MainSettings.self)
    }

    func updateItem(id: String, title: String) {
        guard let setting = localRealm.objects(MainSettings.self).first else { return }
        setting.platformID = id
        setting.platformTitle = title
    }
}
