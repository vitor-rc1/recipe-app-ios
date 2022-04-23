//
//  FoodTabBarEnums.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Foundation

enum TabBarPage: Int {
    case food = 0
    case explore = 1
    case drink = 2
    case profile = 3

    func pageTitleValue() -> String {
        switch self {
        case .food:
            return "Foods"
        case .explore:
            return "Explore foods"
        case .drink:
            return "Drinks"
        case .profile:
            return  "Profile"
        }
    }

    func pageImageName() -> String {
        switch self {
        case .food:
            return "food"
        case .explore:
            return "explore"
        case .drink:
            return "drink"
        case .profile:
            return  "profile"
        }
    }
}
