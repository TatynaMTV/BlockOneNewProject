//
//  LoadDataService.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 29.05.2022.
//

import Foundation

public class DataLoader {
    
    func getCategoryType<T: Decodable>(type: T.Type, fileName: String, format: String, completion: @escaping (Result<[T]?, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: format) else { return }
        DispatchQueue.global(qos: .background).async {
            do {
                guard let data = try? Data(contentsOf: url) else {return}
                let dataFromJson = try JSONDecoder().decode([T].self, from: data)
                completion(.success(dataFromJson))
            } catch let jsonError {
                print("Faild to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }
    }
}
