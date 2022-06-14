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
    let api: FoodAPI

    init(navCon: UINavigationController, api: FoodAPI) {
        self.navigationController = navCon
        self.api = api
    }

    func start() {
        goToFoodDetails()
    }
}

extension FoodDetailsCoordinator: FoodDetailsNavigation {
    func goToFoodDetails() {
        let sessionManager = Alamofire.Session()
        let service = FoodService<FoodType>(sessionManager: sessionManager, api: api)
        let viewModel = FoodDetailsViewModel(foodDetailsNavigation: self, service: service)
        let foodDetailsView = FoodDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(foodDetailsView, animated: true)
    }
}
