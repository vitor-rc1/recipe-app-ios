//
//  FoodViewModel.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import Foundation

final class FoodViewModel<FoodType: Codable>: FoodViewModelProtocol {
    weak var delegate: FoodViewModelDelegateProtocol?
    weak var foodNavigation: FoodNavigation?
    var service: FoodServiceProtocol

    init(foodNavigation: FoodNavigation, service: FoodServiceProtocol) {
        self.foodNavigation = foodNavigation
        self.service = service
    }

    func loadFood() {
        service.getFoodAPIData(url: FoodAPI<FoodType>.foods, type: FoodType.self) { result in
            switch result {
            case .success(let responseFoods):
                let foods = Foods(responseFoods)
                self.delegate?.didLoadedFood(foods: foods.foods)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
