//
//  FoodCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Alamofire

import Foundation
import UIKit

final class FoodCoordinator<FoodCodable: Codable>: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let api: FoodAPI
    let foodType: FoodType
    let detailsFactory: FoodDetailsFactoryProtocol

    init(navCon: UINavigationController,
         api: FoodAPI,
         foodType: FoodType,
         detailsFactory: FoodDetailsFactoryProtocol) {
        self.navigationController = navCon
        self.api = api
        self.foodType = foodType
        self.detailsFactory = detailsFactory
    }

    func start() {
        goToFoodView()
    }
}

extension FoodCoordinator: FoodNavigation {
    func goToFoodDetail(foodId: String) {
        var foodDetailsCoordinator = detailsFactory.make(foodId: foodId,
                                                         foodType: foodType,
                                                         navigationController: navigationController)
        children.append(foodDetailsCoordinator)
        foodDetailsCoordinator.parentCoordinator = self
        foodDetailsCoordinator.start()
    }

    func goToFoodView() {
        let sessionManager = Alamofire.Session()
        let service = FoodService<FoodCodable>(sessionManager: sessionManager, api: api)
        let foodViewModel = FoodViewModel(foodNavigation: self, service: service)
        let foodVC = FoodViewController(viewModel: foodViewModel)
        foodViewModel.delegate = foodVC
        foodVC.title = navigationController.tabBarItem.title
        navigationController.pushViewController(foodVC, animated: true)
    }
}
