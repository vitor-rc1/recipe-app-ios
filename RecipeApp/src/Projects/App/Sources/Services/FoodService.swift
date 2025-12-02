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
        request(url: api.foods(), completion: completion)
    }

    func getFoodById(id: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        request(url: api.foodById(id: id), completion: completion)
    }

    func getFoodByName(name: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        request(url: api.foodByName(name: name), completion: completion)
    }

    func getFoodsByIngredient(ingredient: String,
                              completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        request(url: api.foodsByIngredient(ingredient: ingredient), completion: completion)
    }
    func getFoodsByFirstLettter(letter: String,
                                completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        request(url: api.foodsByFirstLettter(letter: letter), completion: completion)
    }
    func getRandomFood(completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        request(url: api.randomFood(), completion: completion)
    }

    private func request(url: String,
                         completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(url)
            .responseDecodable(of: FoodType.self) { response in
                switch response.result {
                case .success(let foods):
                    DispatchQueue.main.async {
                        completion(.success(Foods(foods)))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
    }
}
