//
//  File.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation

struct Meal: Codable {
    let id: String
    let name: String
    let thumb: String
    let category: String
    let videoURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
        case category = "strCategory"
        case videoURL = "strYoutube"
      }
}
