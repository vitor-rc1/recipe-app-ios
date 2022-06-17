//
//  FoodTabBarController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class FoodTabBarController: UITabBarController {
    weak var foodTabBarNavigation: FoodTabBarNavigation?

    convenience init(foodTabBarNavigation: FoodTabBarNavigation?, controllers: [UIViewController]) {
        self.init(nibName: nil, bundle: nil)
        self.foodTabBarNavigation = foodTabBarNavigation
        self.setViewControllers(controllers, animated: true)
    }
}
