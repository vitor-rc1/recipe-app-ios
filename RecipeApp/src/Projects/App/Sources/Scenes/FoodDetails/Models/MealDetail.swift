//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

struct MealsResponse: Codable {
    let meals: [MealDetail]?

    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct MealDetail: FoodDetailsProtocol {
    var id: String
    var name: String
    var thumb: String
    var ingredients: [String]
    var category: String?
    var instructions: String?
}

extension MealDetail: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
        case category = "strCategory"
        case instructions = "strInstructions"
        case ingredients
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        thumb = try container.decode(String.self, forKey: .thumb)
        category = try? container.decode(String.self, forKey: .category)
        instructions = try? container.decode(String.self, forKey: .instructions)

        var ingredientsList: [String] = []
        self.ingredients = ingredientsList
    }

}
