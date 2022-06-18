//
//  EmptyCollectionViewCell.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class EmptyCollectionViewCell: UICollectionViewCell {
    private lazy var cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.text = "Oops! Recipes\nnot found"
        cellLabel.textAlignment = .center
        cellLabel.font = .systemFont(ofSize: 19, weight: .bold)
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        return cellLabel
    }()
    private lazy var cellImage: UIImageView = {
        let cellImage = UIImageView()
        cellImage.image = UIImage(named: "frying-pan")
        cellImage.contentMode = .scaleAspectFit
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        return cellImage
    }()
    
    func setupCell() {
        setupView()
    }
}

extension EmptyCollectionViewCell: ViewCode {
    func buildViewHierarch() {
        addSubview(cellLabel)
        addSubview(cellImage)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            cellLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cellImage.topAnchor.constraint(equalTo: cellLabel.bottomAnchor),
            cellImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
