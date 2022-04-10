//
//  FoodTabBarController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

class FoodTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaultView()
    }
    
    func loadDefaultView() {
        let foodCollectionVC = FoodCollectionViewController(collectionViewLayout: UICollectionViewLayout())

        foodCollectionVC.title = "Foods"
        foodCollectionVC.tabBarItem.image = UIImage(systemName: "person.3")

        self.setViewControllers([foodCollectionVC], animated: true)
    }
}
