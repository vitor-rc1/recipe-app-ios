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

    private var isLoading: Bool = true

    convenience init(viewModel: FoodViewModelProtocol) {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(EmptyCollectionViewCell.self)
        collectionView?.register(FoodCollectionViewCell.self)
        collectionView.register(LoadingCollectionViewCell.self)
        collectionView.registerHeader(FoodSearchBar.self)
        viewModel?.loadFood()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadFood()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return isLoading ? 1 : 0
        case 1:
            return isLoading ? 0 : recipes.count
        default:
            return recipes.isEmpty && !isLoading ? 1 : 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            return foodCell(indexPath: indexPath)
        } else if indexPath.section == 2 {
            return emptyCell(indexPath: indexPath)
        }

        return loadingCell(indexPath: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let recipe = recipes[indexPath.row]
            viewModel?.didTapFoodCell(id: recipe.id)
            changeToLoadingState()
        }
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

    private func emptyCell(indexPath: IndexPath) -> EmptyCollectionViewCell {
        if let emptyCell = collectionView
            .dequeueReusableCell(EmptyCollectionViewCell.self, for: indexPath) {
            emptyCell.setupCell()
            return emptyCell
        }

        return EmptyCollectionViewCell(frame: .zero)
    }

    private func foodCell(indexPath: IndexPath) -> FoodCollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(FoodCollectionViewCell.self, for: indexPath) {
            let recipe = recipes[indexPath.row]
            cell.setupCell(food: recipe)
            return cell
        }

        return FoodCollectionViewCell()
    }

    private func loadingCell(indexPath: IndexPath) -> LoadingCollectionViewCell {
        if let loadingCell = collectionView
            .dequeueReusableCell(LoadingCollectionViewCell.self, for: indexPath) {
            loadingCell.setupCell()
            return loadingCell
        }

        return LoadingCollectionViewCell(frame: .zero)
    }

    private func changeToLoadingState() {
        isLoading = true
        recipes = []
        collectionView.reloadData()
    }
}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return section == 1 && isLoading == false ? CGSize(width: view.frame.width, height: 130) : CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if recipes.isEmpty || indexPath.section == 0 {
            let margins = view.safeAreaInsets.bottom + view.safeAreaInsets.top
            return CGSize(width: view.bounds.width,
                          height: view.bounds.width - margins)
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
            self.isLoading = false
            self.collectionView.reloadData()
        }
    }

    func didFailLoadedFood() { }
}

extension FoodViewController: FoodSearchBarDelegate {
    func didClickRandomButton() {
        changeToLoadingState()
        viewModel?.randomFood()
    }

    func didClickSearchButton(type: FoodSearchType, searchText: String) {
        changeToLoadingState()
        viewModel?.searchFood(type: type, searchText: searchText)
    }
}
