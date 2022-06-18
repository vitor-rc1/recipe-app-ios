//
//  FoodDetailsViewModelProtocol.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import Foundation

protocol FoodDetailsViewModelProtocol {
    var delegate: FoodDetailsDelegateProtocol? { get set }
    var foodDetailsNavigation: FoodDetailsNavigation? { get set }
    var service: FoodServiceProtocol { get set }
    var id: String { get }

    func getFoodById()
}
