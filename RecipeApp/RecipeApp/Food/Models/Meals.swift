//
//  Meals.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 25/04/22.
//

import Foundation

struct Meals: FoodsProtocol, Codable {
    let meals: [Meal]?
    
    var foods: [Food] {
        meals?.map { Food(food: $0) } ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}
