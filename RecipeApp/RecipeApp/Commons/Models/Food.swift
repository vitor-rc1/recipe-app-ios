//
//  Food.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 21/05/22.
//

import Foundation

struct Food: FoodProtocol {
    let id: String
    let name: String
    let thumb: String
    let ingredients: [String]?
    let category: String?
    let instructions: String?

    init(_ food: FoodProtocol) {
        id = food.id
        name = food.name
        thumb = food.thumb
        ingredients = food.ingredients
        category = food.category
        instructions = food.instructions
    }
}
