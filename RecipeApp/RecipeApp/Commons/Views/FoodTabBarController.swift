//
//  FoodTabBarController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

private let foodCollectionNibName = "FoodCollectionViewController"

class FoodTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultView()
    }
    
    func loadDefaultView() {
        let foodCollectionVC = FoodCollectionViewController(nibName: foodCollectionNibName,
                                                            bundle: nil)

        foodCollectionVC.title = "Foods"
        foodCollectionVC.tabBarItem.image = UIImage(systemName: "person.3")

        self.setViewControllers([foodCollectionVC], animated: true)
    }
}
