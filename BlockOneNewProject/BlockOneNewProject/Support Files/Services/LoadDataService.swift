//
//  LoadDataService.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 29.05.2022.
//

import Foundation

public class DataLoader {
    @Published var categoryData = [CategoryModel]()
    
    init() {
        loadCategory()
    }
    
    func loadCategory() {
        if let fileLocation = Bundle.main.url(forResource: "category", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([CategoryModel].self, from: data)
                
                self.categoryData = dataFromJson
            } catch {
                print(error)
            }
        }
    }
}
