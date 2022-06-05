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
}
