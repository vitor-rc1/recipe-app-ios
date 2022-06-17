//
//  FoodProtocol.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 17/06/22.
//

import Foundation

protocol FoodProtocol {
    var id: String { get }
    var name: String { get }
    var thumb: String { get }
    var ingredients: [String]? { get }
    var category: String? { get }
    var instructions: String? { get }
}

extension FoodProtocol {
    var ingredients: [String]? {
        get {
            let mirror = Mirror(reflecting: self)
            var ingredients: [String] = []
            var measures: [String] = []
            var ingredientsAndMeasures: [String] = []

            let childrens = mirror.children

            for child in childrens {
                if let label = child.label, let value = child.value as? String, !value.isEmpty, value != " " {
                    if label.starts(with: "strIngredient") {
                        ingredients.append(value)
                    } else if label.starts(with: "strMeasure") {
                        measures.append(value)
                    }
                }
            }

            for index in measures.indices {
                ingredientsAndMeasures.append("- \(ingredients[index]) - \(measures[index])")
            }
            return ingredientsAndMeasures
        }
    }
}
