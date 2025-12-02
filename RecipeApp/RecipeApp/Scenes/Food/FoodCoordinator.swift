//
//  FoodCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Foundation
import UIKit
import Alamofire

final class FoodCoordinator<FoodType: Codable>: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let api: FoodAPI

    init(navCon: UINavigationController, api: FoodAPI) {
        self.navigationController = navCon
        self.api = api
    }

    func start() {
        goToFoodView()
    }
}

extension FoodCoordinator: FoodNavigation {
    func goToFoodDetail(food: Food) {
        let foodDetailsCoordinator = FoodDetailsCoordinator<FoodType>(navCon: navigationController, food: food)
        children.append(foodDetailsCoordinator)
        foodDetailsCoordinator.parentCoordinator = self
        foodDetailsCoordinator.start()
    }

    func goToFoodView() {
        let sessionManager = Alamofire.Session()
        let service = FoodService<FoodType>(sessionManager: sessionManager, api: api)
        let foodViewModel = FoodViewModel(foodNavigation: self, service: service)
        let foodVC = FoodViewController(viewModel: foodViewModel)
        foodViewModel.delegate = foodVC
        foodVC.title = navigationController.tabBarItem.title
        navigationController.pushViewController(foodVC, animated: true)
    }
}
