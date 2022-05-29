//
//  Category.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 29/05/22.
//

import Foundation

struct MealCategories: Codable {
    let meals: [Category]
}

struct DrinkCategories: Codable {
    let drinks: [Category]
}

struct Category: Codable {
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
      }
}
