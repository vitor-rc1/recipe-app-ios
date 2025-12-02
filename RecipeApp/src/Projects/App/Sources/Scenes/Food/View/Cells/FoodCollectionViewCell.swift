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

    private lazy var foodNameTextView: UITextView = {
        let foodNameTextView = UITextView()
        foodNameTextView.font = .systemFont(ofSize: 17, weight: .bold)
        foodNameTextView.backgroundColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 0.5)
        foodNameTextView.translatesAutoresizingMaskIntoConstraints = false
        foodNameTextView.isScrollEnabled = false
        foodNameTextView.isEditable = false
        foodNameTextView.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return foodNameTextView
    }()

    private lazy var foodImageView: UIImageView = {
        let foodImageView = UIImageView()
        foodImageView.contentMode = .scaleToFill
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        return foodImageView
    }()

    func setupCell(food: Food) {
        foodNameTextView.text = food.name
//        foodImageView.sd_setImage(with: URL(string: food.thumb))
        setupView()
    }
}

extension FoodCollectionViewCell: ViewCode {
    func buildViewHierarch() {
        foodView.addSubview(foodImageView)
        foodView.addSubview(foodNameTextView)

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
            foodImageView.bottomAnchor.constraint(equalTo: foodView.bottomAnchor),

            foodNameTextView.bottomAnchor.constraint(equalTo: foodImageView.bottomAnchor),
            foodNameTextView.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor),
            foodNameTextView.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor)
        ])
    }
}
