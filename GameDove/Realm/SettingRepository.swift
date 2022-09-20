//
//  SettingRepository.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/20.
//

import Foundation
import RealmSwift

protocol MainPlatformRepositoryType {
    func fetch() -> Results<MainPlatform>!
    func updateItem(id: String, title: String)
}

class MainPlatformRepository: MainPlatformRepositoryType {
    let localRealm = try! Realm()
    
    func fetch() -> Results<MainPlatform>! {
        return localRealm.objects(MainPlatform.self)
    }

    func updateItem(id: String, title: String) {
        guard let setting = localRealm.objects(MainPlatform.self).first else { return }
        setting.id = id
        setting.title = title
    }
}
