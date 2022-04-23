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
    let categroy: String
    let videoURL: String
}
