//
//  FoodServiceProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation

protocol FoodServiceProtocol: AnyObject {
    func getFood(completion: ([Meal]) -> Void)
}
