//
//  CategoryModel.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 26.05.2022.
//

import UIKit

struct CategoryModel: Decodable {
    var title: String
    var events: [Event]
}

struct Event: Decodable {
    var id: Int
    var name: String
    var time: String
    var fond: String
    var address: String
    var telephone: String
    var info: String
    var information: String
}
