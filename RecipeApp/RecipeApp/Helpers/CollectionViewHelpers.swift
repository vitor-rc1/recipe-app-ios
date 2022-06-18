//
//  CollectionViewHelpers.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 12/04/22.
//

import UIKit

extension UICollectionView {
    func register(_ type: UICollectionViewCell.Type) {
        self.register(type, forCellWithReuseIdentifier: className(type))
    }

    func registerHeader(_ type: UICollectionReusableView.Type) {
        self.register(type,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: className(type))

    }

    func dequeueReusableCell<T>(_ type: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: className(type), for: indexPath) as? T
    }

    func dequeueReusableSupplementaryView<T>(_ type: T.Type, kind: String, indexPath: IndexPath) -> T? {
        dequeueReusableSupplementaryView(ofKind: kind,
                                         withReuseIdentifier: className(type),
                                         for: indexPath) as? T
    }

    private func className(_ type: Any.Type) -> String {
        String(describing: type)
    }
}
