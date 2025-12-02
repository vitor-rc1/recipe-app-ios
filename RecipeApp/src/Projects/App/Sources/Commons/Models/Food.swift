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

    init(id: String,
         name: String,
         thumb: String,
         ingredients: [String]? = nil,
         category: String? = nil,
         instructions: String? = nil) {
        self.id = id
        self.name = name
        self.thumb = thumb
        self.ingredients = ingredients
        self.category = category
        self.instructions = instructions
    }
}
