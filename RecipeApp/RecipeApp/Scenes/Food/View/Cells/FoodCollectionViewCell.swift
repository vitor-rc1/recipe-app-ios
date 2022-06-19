//
//  FoodCollectionViewCell.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 11/04/22.
//

import UIKit
import SDWebImage

final class FoodCollectionViewCell: UICollectionViewCell {
    private lazy var foodView: UIView = {
        let foodView = UIView()
        foodView.layer.borderColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.8).cgColor
        foodView.layer.cornerRadius = 10
        foodView.layer.borderWidth = 0.5
        foodView.clipsToBounds = true
        foodView.translatesAutoresizingMaskIntoConstraints = false
        return foodView
    }()

    private lazy var foodNameLabel: UILabel = {
        let foodNameLabel = UILabel()
        foodNameLabel.numberOfLines = 1
        foodNameLabel.textColor = .black
        foodNameLabel.font = .systemFont(ofSize: 17)
        foodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return foodNameLabel
    }()

    private lazy var foodImageView: UIImageView = {
        let foodImageView = UIImageView()
        foodImageView.contentMode = .scaleToFill
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        return foodImageView
    }()

    func setupCell(food: Food) {
        foodNameLabel.text = food.name
        foodImageView.sd_setImage(with: URL(string: food.thumb))
        setupView()
    }
}

extension FoodCollectionViewCell: ViewCode {
    func buildViewHierarch() {
        foodView.addSubview(foodNameLabel)
        foodView.addSubview(foodImageView)

        addSubview(foodView)
    }
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            foodView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            foodView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            foodView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            foodView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),

            foodImageView.topAnchor.constraint(equalTo: foodView.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: foodView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: foodView.trailingAnchor),

            foodNameLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 5),
            foodNameLabel.bottomAnchor.constraint(equalTo: foodView.bottomAnchor, constant: -5),
            foodNameLabel.leadingAnchor.constraint(equalTo: foodView.leadingAnchor, constant: 5),
            foodNameLabel.trailingAnchor.constraint(equalTo: foodView.trailingAnchor)
        ])
    }
}
