//
//  FoodCollectionViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

private let emptyCellIdentifier = "EmptyCell"
private let emptyCellNibName = "EmptyCollectionViewCell"

class FoodCollectionViewController: UICollectionViewController {
    var recipes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UINib(nibName: emptyCellNibName, bundle: nil), forCellWithReuseIdentifier: emptyCellIdentifier)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifier, for: indexPath) as! EmptyCollectionViewCell
        return cell
    }
}
