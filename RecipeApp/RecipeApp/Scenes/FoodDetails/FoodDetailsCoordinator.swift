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
    let id: String

    init(navCon: UINavigationController, api: FoodAPI, id: String) {
        self.navigationController = navCon
        self.api = api
        self.id = id
    }

    func start() {
        goToFoodDetails()
    }
}

extension FoodDetailsCoordinator: FoodDetailsNavigation {
    func goToFoodDetails() {
        let sessionManager = Alamofire.Session()
        let service = FoodService<FoodType>(sessionManager: sessionManager, api: api)
        let viewModel = FoodDetailsViewModel(foodDetailsNavigation: self, service: service, id: id)
        let foodDetailsView = FoodDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(foodDetailsView, animated: true)
    }
}
