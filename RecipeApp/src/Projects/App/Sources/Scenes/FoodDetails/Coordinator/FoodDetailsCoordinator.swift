//
//  FoodDetailsCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import UIKit

final class FoodDetailsCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    var foodDetailsViewController: UIViewController

    init(navCon: UINavigationController,
         foodDetailsViewController: UIViewController) {
        self.navigationController = navCon
        self.foodDetailsViewController = foodDetailsViewController
    }

    func start() {
        goToFoodDetails()
    }
}

extension FoodDetailsCoordinator: FoodDetailsNavigation {
    func goToFoodDetails() {
        foodDetailsViewController.view.backgroundColor = .systemBackground
        navigationController.pushViewController(foodDetailsViewController, animated: true)
    }
}
