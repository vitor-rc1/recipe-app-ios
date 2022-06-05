//
//  FoodService.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
import Alamofire

final class FoodService<FoodType: Codable>: FoodServiceProtocol {
    private var sessionManager: Session?
    private let api: FoodAPI

    init(sessionManager: Session, api: FoodAPI) {
        self.sessionManager = sessionManager
        self.api = api
    }

    func getFoods(completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(api.foods())
            .responseDecodable(of: FoodType.self) { response in
                switch response.result {
                case .success(let foods):
                    completion(.success(Foods(foods)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
