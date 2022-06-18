//
//  AppCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 18/04/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        goToHome()
    }

    func goToHome() {
        let foodTabBarCoordinator = FoodTabBarCoordinator(navCon: navigationController)
        foodTabBarCoordinator.parentCoordinator = self
        children.append(foodTabBarCoordinator)
        foodTabBarCoordinator.start()
    }
}
