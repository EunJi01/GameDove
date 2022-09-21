//
//  RealmModel.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/20.
//

import Foundation
import RealmSwift

class Storage: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var released: String
    @Persisted var regdate = Date()
    
    convenience init(id: Int, title: String, released: String) {
        self.init()
        self.id = id
        self.title = title
        self.released = released
        self.regdate = Date()
    }
}

class MainPlatform: Object {
    @Persisted var id: String
    @Persisted var title: String
    
    @Persisted(primaryKey: true) var setting: String = "setting"
    
    convenience init(id: String, title: String) {
        self.init()
        self.id = id
        self.title = title
    }
}
