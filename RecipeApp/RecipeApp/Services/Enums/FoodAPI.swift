//
//  ApiFoods.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 04/05/22.
//

import Foundation

enum FoodAPI {
    case meals
    case mealByName(name: String)
    case mealById(id: String)
    case mealFirstLettter(letter: String)
    case mealRandom
    case drinks

    private var baseURL: String {
        switch self {
        case .meals, .mealByName, .mealById, .mealFirstLettter, .mealRandom:
            return "https://www.themealdb.com/api/json/v1/1"
        case .drinks:
            return ""
        }
    }

    var apiURL: String {
        switch self {
        case .meals:
            return "\(baseURL)/search.php?s="
        case .mealByName(let name):
            return "\(baseURL)/search.php?s=\(name)"
        case . mealById(let id):
            return "\(baseURL)/lookup.php?i=\(id)"
        case .mealFirstLettter(let letter):
            return "\(baseURL)/search.php?f=\(letter)"
        case .mealRandom:
            return "\(baseURL)/random.php"
        case .drinks:
            return ""
        }
    }
}
