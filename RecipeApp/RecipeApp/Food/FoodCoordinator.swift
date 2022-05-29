//
//  FoodCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Foundation
import UIKit
import Alamofire

class FoodCoordinator<FoodType: Codable>: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        goToFoodView()
    }
}

extension FoodCoordinator: FoodNavigation {
    func goToFoodView() {
        let sessionManager = Alamofire.Session()
        let service = FoodService(sessionManager: sessionManager)
        let foodViewModel = FoodViewModel<FoodType>(foodNavigation: self, service: service)
        let foodVC = FoodViewController(viewModel: foodViewModel)
        foodViewModel.delegate = foodVC
        navigationController.pushViewController(foodVC, animated: true)
    }
}
