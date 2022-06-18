//
//  FoodCollectionViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class FoodViewController: UICollectionViewController {
    private var viewModel: FoodViewModelProtocol?
    private var recipes: [Food] = []

    convenience init(viewModel: FoodViewModelProtocol) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(EmptyCollectionViewCell.self)
        collectionView?.register(FoodCollectionViewCell.self)
        collectionView.registerHeader(FoodSearchBar.self)
        setupView()
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
            let emptyCell = emptyCell(indexPath: indexPath)
            emptyCell.setupCell()
            return emptyCell
        }

        return foodCell(indexPath: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        viewModel?.didTapFoodCell(id: recipe.id)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(FoodSearchBar.self,
                                                                     kind: kind,
                                                                     indexPath: indexPath) ?? FoodSearchBar()
        header.delegate = self
        return header
    }

    func emptyCell(indexPath: IndexPath) -> EmptyCollectionViewCell {
        return collectionView
            .dequeueReusableCell(EmptyCollectionViewCell.self, for: indexPath) ?? EmptyCollectionViewCell(frame: .zero)
    }

    func foodCell(indexPath: IndexPath) -> FoodCollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(FoodCollectionViewCell.self, for: indexPath) {
            let recipe = recipes[indexPath.row]
            cell.setupCell(food: recipe)
            return cell
        }

        return FoodCollectionViewCell()
    }
}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if recipes.isEmpty {
            let margins = view.safeAreaInsets.bottom + view.safeAreaInsets.top
            return CGSize(width: view.bounds.width,
                          height: view.bounds.height - margins)
        }

        let foodSize = (view.bounds.width / 2)
        return CGSize(width: foodSize, height: foodSize)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FoodViewController: FoodViewModelDelegateProtocol {
    func didLoadedFood(foods: [Food]) {
        self.recipes = foods
        guaranteeMainThread {
            self.collectionView.reloadData()
        }
    }

    func didFailLoadedFood() { }
}

extension FoodViewController: FoodSearchBarDelegate {
    func didClickRandomButton() {
        viewModel?.randomFood()
    }

    func didClickSearchButton(type: FoodSearchType, searchText: String) {
        viewModel?.searchFood(type: type, searchText: searchText)
    }
}

extension FoodViewController: ViewCode {
    func buildViewHierarch() {}

    func setUpConstraints() {}

    func additionalConfiguration() {}
}
