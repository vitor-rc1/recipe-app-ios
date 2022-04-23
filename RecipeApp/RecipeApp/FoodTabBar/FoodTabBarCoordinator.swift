//
//  FoodTabBarCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

import Foundation
import UIKit

class FoodTabBarCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        prepareFoodTabBar()
    }
}

extension FoodTabBarCoordinator: FoodTabBarNavigation {

    private func prepareFoodTabBar() {
        let pages: [TabBarPage] = [.food, .explore, .drink, .profile]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        let foodTabBarController = FoodTabBarController(foodTabBarNavigation: self, controllers: controllers)
        navigationController.pushViewController(foodTabBarController, animated: true)
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                     image: UIImage(named: page.pageImageName()),
                                                     tag: page.rawValue)
        switch page {
        case .food:
            let foodCoordinator = FoodCoordinator(navCon: navController)
            children.append(foodCoordinator)
            foodCoordinator.parentCoordinator = self
            foodCoordinator.start()
        case .explore:
            let foodVC = UIViewController()
            navController.pushViewController(foodVC, animated: true)
        case .drink:
            let foodVC = UIViewController()
            navController.pushViewController(foodVC, animated: true)
        case .profile:
            let foodVC = UIViewController()
            navController.pushViewController(foodVC, animated: true)
        }

        return navController
    }
}
