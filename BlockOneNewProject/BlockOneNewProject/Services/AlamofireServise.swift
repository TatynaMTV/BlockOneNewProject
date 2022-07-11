//
//  AlamofireServise.swift
//  BlockOneNewProject
//
//  Created by Татьяна Мальчик on 11.07.2022.
//

import Foundation
import Alamofire

class AlamofireSevice {
    let urlFireDatabase = "https://blockonenewproject-default-rtdb.firebaseio.com/Categories/.json"

    func isonAlamofire(completion: @escaping (CategoryModel) -> Void) {
        AF.request(urlFireDatabase).response { response in
            guard let data = response.data else { return }
            do {
               let decoder = JSONDecoder()
                let json = try decoder.decode(CategoryModel.self, from: data)
                DispatchQueue.main.async {
                    completion(json)
                    print(json)
                }
            } catch {
                print("\(error)")
            }
        }
    }

}
