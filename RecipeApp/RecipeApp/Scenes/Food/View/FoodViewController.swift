//
//  FoodCollectionViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class FoodViewController: UICollectionViewController {
    private lazy var foodSearchBar: FoodSearchBar = {
        let foodSearchBar = FoodSearchBar()
        foodSearchBar.translatesAutoresizingMaskIntoConstraints = false
        foodSearchBar.isHidden = true
        return foodSearchBar
    }()

    private lazy var searchButton: UIBarButtonItem = {
        let searchButton = UIBarButtonItem(image: UIImage(named: "search-icon"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(showSearchBar))
        return searchButton
    }()

    private var viewModel: FoodViewModelProtocol?

    private var recipes = [Food]()
    private var isHiddingFoodSearchBar: Bool = true {
        didSet {
            foodSearchBar.isHidden = isHiddingFoodSearchBar
        }
    }

    convenience init(viewModel: FoodViewModelProtocol) {
        self.init(nibName: "FoodViewController", bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(EmptyCollectionViewCell.self)
        collectionView?.register(FoodCollectionViewCell.self)
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
            return emptyCell(indexPath: indexPath)
        }

        return foodCell(indexPath: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        viewModel?.didTapFoodCell(id: recipe.id)
    }

    func emptyCell(indexPath: IndexPath) -> EmptyCollectionViewCell {
        return collectionView.dequeueReusableCell(EmptyCollectionViewCell.self, for: indexPath) ?? EmptyCollectionViewCell()
    }

    func foodCell(indexPath: IndexPath) -> FoodCollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(FoodCollectionViewCell.self, for: indexPath) {
            let recipe = recipes[indexPath.row]
            cell.setupCell(food: recipe)
            return cell
        }

        return FoodCollectionViewCell()
    }

    @objc func showSearchBar() {
        isHiddingFoodSearchBar = !isHiddingFoodSearchBar
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
        guaranteeMainThread {
            self.collectionView.reloadData()
        }
    }

    func didFailLoadedFood() { }
}

extension FoodViewController: FoodSearchBarDelegate {
    func didClickkRandomButton() {
        viewModel?.randomFood()
        isHiddingFoodSearchBar = true
    }

    func didClickSearchButton(type: FoodSearchType, searchText: String) {
        viewModel?.searchFood(type: type, searchText: searchText)
        isHiddingFoodSearchBar = true
    }
}

extension FoodViewController: ViewCode {
    func buildViewHierarch() {
        view.addSubview(foodSearchBar)
        navigationItem.rightBarButtonItem = searchButton
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            foodSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            foodSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func additionalConfiguration() {
        foodSearchBar.delegate = self
    }
}
