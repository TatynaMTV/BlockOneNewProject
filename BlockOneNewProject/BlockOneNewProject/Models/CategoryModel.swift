//
//  CategoryModel.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 26.05.2022.
//

import UIKit

struct CategoryModel: Decodable {
    var title: String
    var info: String
    var time: String
    var events: [Event]
}

struct Event: Decodable {
    var id: Int
    var name: String
    var fond: String
    var address: String
    var telephone: String
    var information: String
}
