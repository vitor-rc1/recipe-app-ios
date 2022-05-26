//
//  FoodProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 12/04/22.
//

import Foundation

protocol FoodViewModelProtocol {
    var delegate: FoodViewModelDelegateProtocol? { get set }
    var foodNavigation: FoodNavigation? { get set }
    var service: FoodServiceProtocol { get set }
    func loadFood()
}

protocol FoodViewModelDelegateProtocol: AnyObject {
    func didLoadedFood(foods: [Food])
    func didFailLoadedFood()
}

protocol FoodNavigation: AnyObject {
    func goToFoodView()
}
