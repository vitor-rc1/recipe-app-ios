//
//  Ingredient.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 29/05/22.
//

import Foundation

struct MealIngredients: Codable {
    let meals: [MealIngredient]
}

struct DrinkIngredients: Codable {
    let drinks: [DrinkIngredient]
}

struct MealIngredient: Codable {
    let ingredient: String
    
    enum CodingKeys: String, CodingKey {
        case ingredient = "strIngredient"
      }
}

struct DrinkIngredient: Codable {
    let ingredient: String

    enum CodingKeys: String, CodingKey {
        case ingredient = "strIngredient1"
      }
}
