//
//  ApiFoods.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 04/05/22.
//

import Foundation

enum FoodAPI<TypeFood: Codable> {
    case foods
    case foodByName(name: String)
    case foodById(id: String)
    case foodFirstLettter(letter: String)
    case randomFood
    
    case categories
    case foodsByCategory(category: String)
    case ingredients
    case foodsByIngredient(ingredient: String)

    private var baseURL: String {
        switch TypeFood.self {
        case is Meals.Type:
            return "https://www.themealdb.com/api/json/v1/1"
        case is Drinks.Type:
            return "https://www.thecocktaildb.com/api/json/v1/1"
        default:
            return ""
        }
    }

    var apiURL: String {
        switch self {
        case .foods:
            return "\(baseURL)/search.php?s="
        case .foodByName(let name):
            return "\(baseURL)/search.php?s=\(name)"
        case .foodById(let id):
            return "\(baseURL)/lookup.php?i=\(id)"
        case .foodFirstLettter(let letter):
            return "\(baseURL)/search.php?f=\(letter)"
        case .randomFood:
            return "\(baseURL)/random.php"
        case .categories:
            return "/list.php?c=list"
        case .foodsByCategory(let category):
            return "/filter.php?c=\(category)"
        case .ingredients:
            return "/list.php?i=list"
        case .foodsByIngredient(let ingredient):
            return "/filter.php?i=\(ingredient)"
        }
    }
}
