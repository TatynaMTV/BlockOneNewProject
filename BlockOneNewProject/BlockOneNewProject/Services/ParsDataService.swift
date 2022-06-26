//
//  ParsDataService.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 27.06.2022.
//

import Foundation

class ParsDataService {
    var categories: [CategoryModel]?
    var events: [EventModel]?
    let dataLoader = DataLoader()
    
    func createCategorysCoreData(completion: @escaping (() -> Void)) {
        dataLoader.getCategoryType(type: CategoryModel.self, fileName: "category", format: "json") { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                categories?.forEach { $0.storeCoreData() }
                completion()
            case .failure(let error):
                print("error:", error)
                completion()
            }
        }
    }
    
    func createEventsCoreData(completion: @escaping (() -> Void)) {
        dataLoader.getCategoryType(type: EventModel.self, fileName: "event", format: "json") { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events
                events?.forEach { $0.storeCoreData() }
                completion()
            case .failure(let error):
                print("error:", error)
                completion()
            }
        }
    }
    
    func createCategoryRealm(completion: @escaping (() -> Void)) {
        dataLoader.getCategoryType(type: CategoryModel.self, fileName: "category", format: "json") { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categories = categories
                categories?.forEach { $0.storeRealm() }
                completion()
            case .failure(let error):
                print("error:", error)
                completion()
            }
        }
    }
    
    func createEventsRealm(completion: @escaping (() -> Void)) {
        dataLoader.getCategoryType(type: EventModel.self, fileName: "event", format: "json") { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events
                events?.forEach { $0.storeRealm() }
                completion()
            case .failure(let error):
                print("error:", error)
                completion()
            }
        }
    }
}
