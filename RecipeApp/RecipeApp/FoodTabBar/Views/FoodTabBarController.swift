//
//  FoodTabBarController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class FoodTabBarController: UITabBarController {
    weak var foodTabBarNavigation: FoodTabBarNavigation?

    init(foodTabBarNavigation: FoodTabBarNavigation?, controllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.foodTabBarNavigation = foodTabBarNavigation
        self.setViewControllers(controllers, animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
