//
//  FoodServiceProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation

protocol FoodServiceProtocol: AnyObject {
    func getFood<T: Codable>(url: FoodAPI, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
