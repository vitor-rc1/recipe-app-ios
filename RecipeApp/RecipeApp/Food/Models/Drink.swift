//
//  Drink.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation

struct Drink: Codable {
    let id: String
    let name: String
    let thumb: String

    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumb = "strDrinkThumb"
      }
}
