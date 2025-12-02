//
//  FoodServiceProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
import Alamofire

protocol FoodServiceProtocol: AnyObject {
    func getFoods(completion: @escaping (Result<FoodsProtocol, Error>) -> Void)
    func getFoodById(id: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void)
    func getFoodByName(name: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void)
    func getFoodsByIngredient(ingredient: String,
                              completion: @escaping (Result<FoodsProtocol, Error>) -> Void)
    func getFoodsByFirstLettter(letter: String,
                                completion: @escaping (Result<FoodsProtocol, Error>) -> Void)
    func getRandomFood(completion: @escaping (Result<FoodsProtocol, Error>) -> Void)
}
