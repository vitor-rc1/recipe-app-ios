//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import DependencyInjectionInterfaces
import NetworkingInterfaces

import UIKit

final class FoodDetailsFactory: FoodDetailsFactoryProtocol {
    func make(foodId: String,
              foodType: FoodType,
              navigationController: UINavigationController) -> any Coordinator {
        let resolver = SharedContainer.shared.resolver()
        let networkService: NetworkServiceProtocol = resolver.resolve()

        let decodeType: FoodProtocol.Type
        let endpoint: FoodDetailsEndpoint
        switch foodType {
        case .drink:
            endpoint = DrinkDetailsEndpoint(id: foodId)
            decodeType = Drink.self
        case .meal:
            endpoint = MealDetailsEndpoint(id: foodId)
            decodeType = Meal.self
        }

        let viewModel = FoodDetailsViewModel(networkService: networkService,
                                             endpoint: endpoint,
                                             decodeType: decodeType)

        let viewController = FoodDetailsViewController(viewModel: viewModel)

        let coordinator = FoodDetailsCoordinator(navCon: navigationController,
                                                 foodDetailsViewController: viewController)

        return coordinator
    }
}
