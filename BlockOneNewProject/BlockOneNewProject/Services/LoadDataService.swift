//
//  LoadDataService.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 29.05.2022.
//

import Foundation

public class DataLoader {
    
    func loadCategory(fileName: String) -> [CategoryModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([CategoryModel].self, from: data)
                print(dataFromJson)
                return dataFromJson
            } catch let jsonError {
                print("Faild to decode JSON", jsonError)
            }
        }
        return nil
    }
    
    func loadEvent(fileName: String) -> [EventModel]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([EventModel].self, from: data)
                print(dataFromJson)
                return dataFromJson
            } catch let jsonError {
                print("Faild to decode JSON", jsonError)
            }
        }
        return nil
    }
}
