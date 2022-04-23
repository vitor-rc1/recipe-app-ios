//
//  FoodCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Foundation
import UIKit

class FoodCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        let foodVC = FoodViewController()
        navigationController.pushViewController(foodVC, animated: true)
    }

}
