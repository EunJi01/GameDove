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
    func deleteItem(item: Storage)
}

class StorageRepository: StorageRepositoryType {
    let localRealm = try! Realm()
    
    func fetch() -> Results<Storage>! {
        return localRealm.objects(Storage.self).sorted(byKeyPath: "regdate", ascending: false)
    }

    func deleteItem(item: Storage) {
        do {
            try localRealm.write {
                localRealm.delete(item)
            }
        } catch let error {
            print(error)
        }
    }
}
