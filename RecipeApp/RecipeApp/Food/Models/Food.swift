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
    let category: String
    let videoURL: String?

    init(meal: Meal) {
        id = meal.id
        name = meal.name
        thumb = meal.thumb
        category = meal.category
        videoURL = meal.videoURL
    }

    init(drink: Drink) {
        id = drink.id
        name = drink.name
        thumb = drink.thumb
        category = drink.category
        videoURL = drink.videoURL
    }
}
