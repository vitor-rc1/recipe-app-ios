//
//  FoodCollectionViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class FoodViewController: UICollectionViewController {
    var viewModel: FoodViewModelProtocol?

    var recipes = [Food]()

    convenience init(viewModel: FoodViewModelProtocol) {
        self.init(nibName: "FoodViewController", bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(EmptyCollectionViewCell.self)
        collectionView?.register(FoodCollectionViewCell.self)
        viewModel?.loadFood()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.isEmpty ? 1 : recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if recipes.isEmpty {
            return emptyCell(indexPath: indexPath)
        }

        return foodCell(indexPath: indexPath)
    }

    func emptyCell(indexPath: IndexPath) -> EmptyCollectionViewCell {
        return collectionView.dequeueReusableCell(EmptyCollectionViewCell.self, for: indexPath)!
    }

    func foodCell(indexPath: IndexPath) -> FoodCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(FoodCollectionViewCell.self, for: indexPath)!
        let recipe = recipes[indexPath.row]
        cell.setupCell(food: recipe)
        return cell
    }
}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if recipes.isEmpty {
            let margins = view.safeAreaInsets.bottom + view.safeAreaInsets.top
            return CGSize(width: view.bounds.width,
                          height: view.bounds.height - margins)
        }

        let foodSize = (view.bounds.width / 2) - 5
        return CGSize(width: foodSize, height: foodSize)
    }
}

extension FoodViewController: FoodViewModelDelegateProtocol {
    func didLoadedFood(foods: [Food]) {
        self.recipes = foods
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func didFailLoadedFood() { }
}
