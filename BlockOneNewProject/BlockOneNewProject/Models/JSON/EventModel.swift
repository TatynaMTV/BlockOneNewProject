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
}
