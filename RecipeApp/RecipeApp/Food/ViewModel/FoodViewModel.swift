//
//  FoodViewModel.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import Foundation

final class FoodViewModel: FoodViewModelProtocol {
    var delegate: FoodViewModelDelegateProtocol?
    func loadFood() { }
}
