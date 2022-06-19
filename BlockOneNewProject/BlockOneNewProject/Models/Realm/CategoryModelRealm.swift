//
//  CategoryModelRealm.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 20.06.2022.
//

import Foundation
import RealmSwift

class CategoryModelRealm: Object {
    @Persisted var image: String
    @Persisted var title: String
}
