//
//  FoodProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 12/04/22.
//

import Foundation

protocol FoodViewModelProtocol {
    var delegate: FoodViewModelDelegateProtocol? { get set }
    func loadFood()
}

protocol FoodViewModelDelegateProtocol {
    func didLoadedFood()
    func didFailLoadedFood()
}
