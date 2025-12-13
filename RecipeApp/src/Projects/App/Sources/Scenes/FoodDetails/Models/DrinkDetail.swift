//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

struct DrinksResponse: Codable {
    let drinks: [DrinkDetail]?

    enum CodingKeys: String, CodingKey {
        case drinks
    }
}

struct DrinkDetail: FoodDetailsProtocol {
    var id: String
    var name: String
    var thumb: String
    var ingredients: [String]
    var category: String?
    var instructions: String?
}

extension DrinkDetail: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumb = "strDrinkThumb"
        case category = "strAlcoholic"
        case instructions = "strInstructions"
        case ingredients
    }
}
