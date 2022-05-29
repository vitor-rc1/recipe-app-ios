//
//  Drinks.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 04/05/22.
//

import Foundation

struct Drinks: FoodsProtocol, Codable {
    let drinks: [Drink]?
    
    var foods: [Food] {
        drinks?.map { Food(food: $0) } ?? []
    }
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
}
