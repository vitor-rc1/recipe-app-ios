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

        let detailsAdapter: FoodDetailsAdapterProtocol
        let endpoint: FoodDetailsEndpoint
        switch foodType {
        case .drink:
            endpoint = DrinkDetailsEndpoint(id: foodId)
            detailsAdapter = DrinksDetailsAdapter()
        case .meal:
            endpoint = MealDetailsEndpoint(id: foodId)
            detailsAdapter = MealDetailsAdapter()
        }

        let viewModel = FoodDetailsViewModel(networkService: networkService,
                                             endpoint: endpoint,
                                             detailsAdapter: detailsAdapter)

        let viewController = FoodDetailsViewController(viewModel: viewModel)

        let coordinator = FoodDetailsCoordinator(navCon: navigationController,
                                                 foodDetailsViewController: viewController)

        viewModel.viewController = viewController

        return coordinator
    }
}
