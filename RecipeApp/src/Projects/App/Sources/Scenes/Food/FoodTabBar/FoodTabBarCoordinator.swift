//
//  FoodTabBarCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import DependencyInjectionInterfaces

import Foundation
import UIKit

final class FoodTabBarCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        prepareFoodTabBar()
    }

    private func prepareFoodTabBar() {
        let pages: [TabBarPage] = [.food, .drink]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        let foodTabBarController = FoodTabBarController(foodTabBarNavigation: self, controllers: controllers)
        navigationController.pushViewController(foodTabBarController, animated: true)
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                     image: UIImage(named: page.pageImageName()),
                                                     tag: page.rawValue)
        let resolver = SharedContainer.shared.resolver()
        let foodDetailsFactory: FoodDetailsFactoryProtocol = resolver.resolve()

        switch page {
        case .food:
            let foodCoordinator = FoodCoordinator<Meals>(navCon: navController,
                                                         api: .meal,
                                                         foodType: .meal,
                                                         detailsFactory: foodDetailsFactory)
            children.append(foodCoordinator)
            foodCoordinator.parentCoordinator = self
            foodCoordinator.start()
        case .drink:
            let foodCoordinator = FoodCoordinator<Drinks>(navCon: navController,
                                                          api: .drink,
                                                          foodType: .drink,
                                                          detailsFactory: foodDetailsFactory)
            children.append(foodCoordinator)
            foodCoordinator.parentCoordinator = self
            foodCoordinator.start()
        }

        return navController
    }
}

extension FoodTabBarCoordinator: FoodTabBarNavigation {

}
