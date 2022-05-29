//
//  Food.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 21/05/22.
//

import Foundation

struct Food {
    let id: String
    let name: String
    let thumb: String

    init(meal: Meal) {
        id = meal.id
        name = meal.name
        thumb = meal.thumb
    }

    init(drink: Drink) {
        id = drink.id
        name = drink.name
        thumb = drink.thumb
    }
}
