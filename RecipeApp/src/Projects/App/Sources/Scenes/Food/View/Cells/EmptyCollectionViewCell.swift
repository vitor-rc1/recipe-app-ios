//
//  EmptyCollectionViewCell.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import UIKit

final class EmptyCollectionViewCell: UICollectionViewCell {
    private lazy var emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.text = "Oops!\nRecipes not found."
        emptyLabel.textAlignment = .center
        emptyLabel.font = .systemFont(ofSize: 19, weight: .bold)
        emptyLabel.numberOfLines = 0
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        return emptyLabel
    }()

    private lazy var emptyImageView: UIImageView = {
        let emptyImageView = UIImageView()
        emptyImageView.image = UIImage(named: "frying-pan")
        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.layer.cornerRadius = 100
        emptyImageView.layer.borderWidth = 0.5
        emptyImageView.clipsToBounds = true
        emptyImageView.backgroundColor = .white
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        return emptyImageView
    }()

    func setupCell() {
        setupView()
    }
}

extension EmptyCollectionViewCell: ViewCode {
    func buildViewHierarch() {
        addSubview(emptyLabel)
        addSubview(emptyImageView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            emptyImageView.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 15),
            emptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 200),
            emptyImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
