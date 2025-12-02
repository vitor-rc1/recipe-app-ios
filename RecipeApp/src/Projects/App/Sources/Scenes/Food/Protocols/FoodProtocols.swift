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
    func randomFood()
    func searchFood(type: FoodSearchType, searchText: String)
    func didTapFoodCell(id: String)
}

protocol FoodViewModelDelegateProtocol: AnyObject {
    func didLoadedFood(foods: [Food])
    func didFailLoadedFood(title: String, error: String)
}

protocol FoodNavigation: AnyObject {
    func goToFoodView()
    func goToFoodDetail(food: Food)
}
