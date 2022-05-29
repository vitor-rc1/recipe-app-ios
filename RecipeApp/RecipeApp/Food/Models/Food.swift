//
//  Food.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 21/05/22.
//

import Foundation

protocol FoodProtocol {
    var id: String { get }
    var name: String { get }
    var thumb: String { get }
}

struct Food {
    let id: String
    let name: String
    let thumb: String

    init(food: FoodProtocol) {
        id = food.id
        name = food.name
        thumb = food.thumb
    }
}
