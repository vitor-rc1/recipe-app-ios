//
//  ApiFoods.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 04/05/22.
//

import Foundation

enum FoodAPI {
    case meal
    case drink

    private var baseURL: String {
        switch self {
        case .meal:
            return "https://www.themealdb.com/api/json/v1/1"
        case .drink:
            return "https://www.thecocktaildb.com/api/json/v1/1"
        }
    }

    func foods() -> String { "\(baseURL)/search.php?s=" }
    func foodByName(name: String) -> String { "\(baseURL)/search.php?s=\(name)" }
    func foodById(id: String) -> String { "\(baseURL)/lookup.php?i=\(id)" }
    func foodsByIngredient(ingredient: String) -> String { "\(baseURL)/filter.php?i=\(ingredient)" }
    func foodsByFirstLettter(letter: String) -> String { "\(baseURL)/search.php?f=\(letter)" }
    func randomFood() -> String { "\(baseURL)/random.php" }
}
