//
//  FoodDetailsViewModel.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import Foundation

final class FoodDetailsViewModel: FoodDetailsViewModelProtocol {
    weak var delegate: FoodDetailsDelegateProtocol?
    var foodDetailsNavigation: FoodDetailsNavigation?
    var service: FoodServiceProtocol
    
    init(foodDetailsNavigation: FoodDetailsNavigation, service: FoodServiceProtocol) {
        self.foodDetailsNavigation = foodDetailsNavigation
        self.service = service
    }

    func getFoodById(id: String) {
        service.getFoodById(id: id) { result in
            switch result {
            case .success(let foods):
//                self.delegate?.didLoadedFood(foods: foods.foods)
                print(foods.foods.first)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
