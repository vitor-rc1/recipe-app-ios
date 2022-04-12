//
//  FoodCollectionViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

class FoodViewController: UICollectionViewController {
    var recipes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(EmptyCollectionViewCell.self)
        self.collectionView?.register(FoodCollectionViewCell.self)
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
            return CGSize(width: 200, height: 200)
        }
}

extension UICollectionView {
    func register(_ type: UICollectionViewCell.Type) {
        let className = String(describing: type)
        self.register(UINib(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? T
    }
}
