//
//  StorageRepository.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/20.
//

import Foundation
import RealmSwift

protocol StorageRepositoryType {
    func fetch() -> Results<Storage>!
    func deleteGame(game: Storage)
    func deleteAll()
    func canStore(id: Int) -> Bool
}

class StorageRepository: StorageRepositoryType {
    let localRealm = try! Realm() // MARK: 나중에 do-catch로 바꾸기
    
    func fetch() -> Results<Storage>! {
        return localRealm.objects(Storage.self).sorted(byKeyPath: "regdate", ascending: false)
    }

    func deleteGame(game: Storage) {
        do {
            try localRealm.write {
                localRealm.delete(game)
            }
        } catch let error {
            print(error)
        }
    }
    
    func deleteAll() {
        do {
            try localRealm.write {
                let games = localRealm.objects(Storage.self)
                localRealm.delete(games)
            }
        } catch let error {
            print(error)
        }
    }
    
    func canStore(id: Int) -> Bool {
        guard localRealm.objects(Storage.self).filter("id == \(id)").isEmpty else {
            return false
        }
        return true
    }
}
