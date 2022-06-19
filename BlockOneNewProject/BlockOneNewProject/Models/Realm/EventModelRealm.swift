//
//  EventModelRealm.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 20.06.2022.
//

import Foundation
import RealmSwift

class EventModelRealm: Object {
    @Persisted var id: Int16
    @Persisted var image: String
    @Persisted var name: String
    @Persisted var time: String
    @Persisted var fond: String
    @Persisted var address: String
    @Persisted var phone: String
    @Persisted var info: String
    @Persisted var information: String
}

