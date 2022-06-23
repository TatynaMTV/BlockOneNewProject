//
//  CategoryModel.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 26.05.2022.
//

import UIKit

struct CategoryModel: Decodable {
    var image: String
    var title: String
    
    static let databaseCD = CoreDataManager.shared
    static let databaseRS = RealmManager.shared
    
    func storeCoreData() {
        guard let category = CategoryModel.databaseCD.add(Category.self) else { return }
        category.image = image
        category.title = title
    }
    
    func storeRealm() {
//        guard let category = CategoryModel.databaseRS.
    }
}
