//
//  FoodCollectionViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class FoodViewController: UICollectionViewController {
    var viewModel: FoodViewModelProtocol
    
    var recipes = [String]()
    
    init(viewModel: FoodViewModelProtocol = FoodViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "FoodViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(EmptyCollectionViewCell.self)
        self.collectionView?.register(FoodCollectionViewCell.self)
        self.viewModel.loadFood()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.isEmpty ? 1 : recipes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
        cell.label.text = recipes[indexPath.row]
        return cell
    }
}

extension FoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if recipes.isEmpty {
            return CGSize(width: view.bounds.width, height: view.bounds.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top)
        }
        
        let foodSize = (view.bounds.width / 2) - 5
        return CGSize(width: foodSize, height: foodSize)
    }
}
