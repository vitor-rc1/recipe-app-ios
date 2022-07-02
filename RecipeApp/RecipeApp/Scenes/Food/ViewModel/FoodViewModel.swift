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
        service.getFoods { [weak self] response in
            self?.handleResponse(response: response)
        }
    }

    func randomFood() {
        service.getRandomFood { [weak self] response in
            switch response {
            case .success(let foods):
                if let randomFood = foods.foods.first {
                    self?.foodNavigation?.goToFoodDetail(food: randomFood)
                }
            case .failure(let error):
                self?.delegate?.didFailLoadedFood(title: "Error on load random food.",
                                                  error: error.localizedDescription)
            }
        }
    }

    func searchFood(type: FoodSearchType, searchText: String) {
        let searchTextFiltered = searchText.replacingOccurrences(of: " ", with: "_")
        switch type {
        case .foodByName:
            service.getFoodByName(name: searchTextFiltered) {[weak self] response in
                self?.handleResponse(response: response)
            }
        case .foodByIngredient:
            service.getFoodsByIngredient(ingredient: searchTextFiltered) { [weak self] response in
                self?.handleResponse(response: response)
            }
        case .foodByFirstLetter:
            if searchTextFiltered.count == 1 {
                service.getFoodsByFirstLettter(letter: searchTextFiltered) { [weak self] response in
                    self?.handleResponse(response: response)
                }
            } else {
                delegate?.didFailLoadedFood(title: "Validation error.",
                                            error: "Please insert one character for search by first letter")
            }
        }
    }

    func didTapFoodCell(id: String) {
        service.getFoodById(id: id) { [weak self] result in
            switch result {
            case .success(let foods):
                if let food = foods.foods.first {
                    self?.foodNavigation?.goToFoodDetail(food: food)
                }
            case .failure(let error):
                self?.delegate?.didFailLoadedFood(title: "Error on load food by id.", error: error.localizedDescription)
            }
        }
    }

    private func handleResponse(response: Result<FoodsProtocol, Error>) {
        switch response {
        case .success(let foods):
            self.delegate?.didLoadedFood(foods: foods.foods)
        case .failure(let error):
            self.delegate?.didFailLoadedFood(title: "Error on load foods.", error: error.localizedDescription)
        }
    }
}
