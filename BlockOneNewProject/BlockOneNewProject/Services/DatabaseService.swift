//
//  DatabaseService.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 11.07.2022.
//

import Foundation

class DatabaseService {
    let loadLocalData = DataLoader()
    func loadDataFB<T: Decodable>(type: T.Type, urlString: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if error != nil {
                    print("load data from local file ")
                    return
                }
                guard let data = data else { return }
                do {
                    let decodedLists = try JSONDecoder().decode([T].self, from: data)
                    print("finished getting services")
                    completion(.success(decodedLists))
                } catch let jsonError {
                    print("Faild to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
