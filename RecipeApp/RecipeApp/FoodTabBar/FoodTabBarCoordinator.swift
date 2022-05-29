//
//  FoodTabBarCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 22/04/22.
//

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
        let pages: [TabBarPage] = [.food, .drink, .profile]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        let foodTabBarController = FoodTabBarController(foodTabBarNavigation: self, controllers: controllers)
        foodTabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(foodTabBarController, animated: true)
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(title: page.pageTitleValue(),
                                                     image: UIImage(named: page.pageImageName()),
                                                     tag: page.rawValue)
        switch page {
        case .food:
            let foodCoordinator = FoodCoordinator<Meals>(navCon: navController)
            children.append(foodCoordinator)
            foodCoordinator.parentCoordinator = self
            foodCoordinator.start()
        case .drink:
            let foodCoordinator = FoodCoordinator<Drinks>(navCon: navController)
            children.append(foodCoordinator)
            foodCoordinator.parentCoordinator = self
            foodCoordinator.start()
        case .profile:
            let profileVC = UIViewController()
            navController.pushViewController(profileVC, animated: true)
        }

        return navController
    }
}

extension FoodTabBarCoordinator: FoodTabBarNavigation {

}
