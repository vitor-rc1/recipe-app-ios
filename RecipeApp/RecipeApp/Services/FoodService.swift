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
                self.handleResponse(response: response, completion: completion)
            }
    }

    func getFoodById(id: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(api.foodById(id: id))
            .responseDecodable(of: FoodType.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }

    func getFoodByName(name: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(api.foodByName(name: name))
            .responseDecodable(of: FoodType.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }

    func getFoodsByIngredient(ingredient: String,
                              completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(api.foodsByIngredient(ingredient: ingredient))
            .responseDecodable(of: FoodType.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }
    func getFoodsByFirstLettter(letter: String,
                                completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(api.foodsByFirstLettter(letter: letter))
            .responseDecodable(of: FoodType.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }
    func getRandomFood(completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        sessionManager?.request(api.randomFood())
            .responseDecodable(of: FoodType.self) { response in
                self.handleResponse(response: response, completion: completion)
            }
    }

    private func handleResponse(response: DataResponse<FoodType, AFError>,
                                completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        switch response.result {
        case .success(let foods):
            completion(.success(Foods(foods)))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
