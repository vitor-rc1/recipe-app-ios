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
    
    let id: String
    
    init(foodDetailsNavigation: FoodDetailsNavigation, service: FoodServiceProtocol, id: String) {
        self.foodDetailsNavigation = foodDetailsNavigation
        self.service = service
        self.id = id
    }

    func getFoodById() {
        service.getFoodById(id: id) { result in
            switch result {
            case .success(let foods):
                guard let food = foods.foods.first else {
                    return
                }
                self.delegate?.didLoadFood(food: food)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
