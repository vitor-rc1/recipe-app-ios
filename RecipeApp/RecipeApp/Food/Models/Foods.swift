//
//  Foods.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 25/05/22.
//

import Foundation

struct Foods {
    let foods: [Food]

    init(_ foods: Codable) {
        if let meals = foods as? Meals {
            self.foods = meals.meals?.map{Food(meal: $0)} ?? []
        } else if let drinks = foods as? Drinks {
            self.foods = drinks.drinks?.map{Food(drink: $0)} ?? []
        } else {
            self.foods = []
        }
    }
}
