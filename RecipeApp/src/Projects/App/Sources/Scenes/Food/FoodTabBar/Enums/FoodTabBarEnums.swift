//
//  FoodTabBarEnums.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Foundation

enum TabBarPage: Int {
    case food = 0
    case drink = 1

    func pageTitleValue() -> String {
        switch self {
        case .food:
            return "Foods"
        case .drink:
            return "Drinks"
        }
    }

    func pageImageName() -> String {
        switch self {
        case .food:
            return "food"
        case .drink:
            return "drink"
        }
    }
}
