//
//  FoodDetailsCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import UIKit
import Alamofire

final class FoodDetailsCoordinator<FoodType: Codable>: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let food: Food

    init(navCon: UINavigationController, food: Food) {
        self.navigationController = navCon
        self.food = food
    }

    func start() {
        goToFoodDetails()
    }
}

extension FoodDetailsCoordinator: FoodDetailsNavigation {
    func goToFoodDetails() {
        let foodDetailsView = FoodDetailsViewController(food: food)
        navigationController.pushViewController(foodDetailsView, animated: true)
    }
}
