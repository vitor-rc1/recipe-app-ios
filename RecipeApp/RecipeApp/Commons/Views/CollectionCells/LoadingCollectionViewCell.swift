//
//  LoadingCell.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 18/06/22.
//

import UIKit

final class LoadingCollectionViewCell: UICollectionViewCell {
    private lazy var loadingLabel: UILabel = {
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textAlignment = .center
        loadingLabel.font = .systemFont(ofSize: 19, weight: .bold)
        loadingLabel.numberOfLines = 0
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        return loadingLabel
    }()

    private lazy var loadingImageView: UIImageView = {
        let loadingImageView = UIImageView()
        loadingImageView.image = UIImage(named: "fork-spoon")
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.layer.cornerRadius = 100
        loadingImageView.layer.borderWidth = 0.5
        loadingImageView.clipsToBounds = true
        loadingImageView.backgroundColor = .white
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        return loadingImageView
    }()

    func setupCell() {
        setupView()
    }
}

extension LoadingCollectionViewCell: ViewCode {
    func buildViewHierarch() {
        addSubview(loadingLabel)
        addSubview(loadingImageView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            loadingImageView.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 15),
            loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingImageView.heightAnchor.constraint(equalToConstant: 200),
            loadingImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
