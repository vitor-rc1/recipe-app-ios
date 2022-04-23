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
        let foodViewModel = FoodViewModel()
        let foodVC = FoodViewController(viewModel: foodViewModel)
        navigationController.pushViewController(foodVC, animated: true)
    }

}
