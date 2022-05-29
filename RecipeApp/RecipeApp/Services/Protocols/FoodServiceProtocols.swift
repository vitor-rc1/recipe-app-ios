//
//  FoodServiceProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
import Alamofire

protocol FoodServiceProtocol: AnyObject {
    func getFood<FoodType: Codable>(url: FoodAPI<FoodType>,
                                    type: FoodType.Type,
                                    completion: @escaping (Result<FoodType, Error>) -> Void)
}
