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
        service.getFoods { response in
            self.handleResponse(response: response)
        }
    }

    func randomFood() {
        service.getRandomFood { response in
            switch response {
            case .success(let foods):
                if let randomFood = foods.foods.first {
                    self.foodNavigation?.goToFoodDetail(food: randomFood)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func searchFood(type: FoodSearchType, searchText: String) {
        let searchTextFiltered = searchText.replacingOccurrences(of: " ", with: "_")
        switch type {
        case .foodByName:
            service.getFoodByName(name: searchTextFiltered) { response in
                self.handleResponse(response: response)
            }
        case .foodByIngredient:
            service.getFoodsByIngredient(ingredient: searchTextFiltered) { response in
                self.handleResponse(response: response)
            }
        case .foodByFirstLetter:
            service.getFoodsByFirstLettter(letter: searchTextFiltered) { response in
                self.handleResponse(response: response)
            }
        }
    }

    func didTapFoodCell(id: String) {
        service.getFoodById(id: id) { result in
            switch result {
            case .success(let foods):
                guard let food = foods.foods.first else {
                    return
                }
                self.foodNavigation?.goToFoodDetail(food: food)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func handleResponse(response: Result<FoodsProtocol, Error>) {
        switch response {
        case .success(let foods):
            self.delegate?.didLoadedFood(foods: foods.foods)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
