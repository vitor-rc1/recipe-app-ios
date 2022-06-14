//
//  FoodDetailsViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import UIKit

final class FoodDetailsViewController: UIViewController {
    private var viewModel: FoodDetailsViewModelProtocol?

    convenience init(viewModel: FoodDetailsViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FoodDetailsViewController: ViewCode {
    
}
