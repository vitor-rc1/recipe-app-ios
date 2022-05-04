//
//  FoodService.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
import Alamofire

final class FoodService: FoodServiceProtocol {

    func getFood<T: Codable>(url: FoodAPI, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let response = AF.request(url.apiURL)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let foods):
                    completion(.success(foods))
                case .failure(let error):
                    completion(.failure(error))
                }
            }

    }
}
