//
//  RealmManager.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 13.06.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func saveModel<T: Object>(model: T) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func deleteModel<T: Object>(model: T) {
        try! realm.write {
            realm.delete(model)
        }
    }
}
