//
//  EventModel.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 31.05.2022.
//

import Foundation

struct EventModel: Decodable {
    var id: Int16
    var image: String
    var name: String
    var time: String
    var fond: String
    var address: String
    var phone: String
    var info: String
    var information: String
    
    static let databaseCD = CoreDataManager.shared
    static let databaseRS = RealmManager.shared
    
    func storeCoreData() {
        guard let event = EventModel.databaseCD.add(Event.self) else { return }
        event.id = id
        event.image = image
        event.name = name
        event.time = time
        event.fond = fond
        event.address = address
        event.phone = phone
        event.info = info
        event.information = information
        EventModel.databaseCD.save()
    }
    
    func storeRealm() {
        let eventRealm = EventModelRealm()
        eventRealm.id = id
        eventRealm.image = image
        eventRealm.name = name
        eventRealm.time = time
        eventRealm.fond = fond
        eventRealm.address = address
        eventRealm.phone = phone
        eventRealm.info = info
        eventRealm.information = information
        EventModel.databaseRS.saveModel(model: eventRealm)
    }
}
