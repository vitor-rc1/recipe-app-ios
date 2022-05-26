//
//  FoodViewModel.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import Foundation

final class FoodViewModel: FoodViewModelProtocol {
    weak var delegate: FoodViewModelDelegateProtocol?
    weak var foodNavigation: FoodNavigation?
    var service: FoodServiceProtocol

    init(foodNavigation: FoodNavigation, service: FoodServiceProtocol) {
        self.foodNavigation = foodNavigation
        self.service = service
    }

    func loadFood() {
        service.getFood(url: FoodAPI<Meals>.foods, type: Meals.self) { result in
            switch result {
            case .success(let foods):

//                delegate?.didLoadedFood(foods: foods)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
