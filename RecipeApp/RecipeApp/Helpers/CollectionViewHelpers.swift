//
//  CollectionViewHelpers.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 12/04/22.
//

import UIKit

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
