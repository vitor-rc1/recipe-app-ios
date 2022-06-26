//
//  FoodDetailsViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import UIKit

final class FoodDetailsViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var foodImageView: UIImageView = {
        let foodImageView = UIImageView()
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        foodImageView.image = UIImage(named: "frying-pan")
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.layer.masksToBounds = true
        return foodImageView
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        return nameLabel
    }()

    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = .systemFont(ofSize: 15)
        categoryLabel.textColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)
        return categoryLabel
    }()

    private lazy var ingredientsTitleLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients"
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.font = .systemFont(ofSize: 20)
        return ingredientsLabel
    }()

    private lazy var ingredientsTextView: UITextView = {
        let ingredientsTextView = UITextView()
        ingredientsTextView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsTextView.font = .systemFont(ofSize: 15)
        ingredientsTextView.isScrollEnabled = false
        ingredientsTextView.isEditable = false
        ingredientsTextView.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        ingredientsTextView.backgroundColor = .systemGray5
        return ingredientsTextView
    }()

    private lazy var instructionsTitleLabel: UILabel = {
        let instructionssLabel = UILabel()
        instructionssLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionssLabel.text = "Instructions"
        instructionssLabel.font = .systemFont(ofSize: 20)
        return instructionssLabel
    }()

    private lazy var instructionsTextView: UITextView = {
        let instructionsTextView = UITextView()
        instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        instructionsTextView.font = .systemFont(ofSize: 13)
        instructionsTextView.isScrollEnabled = false
        instructionsTextView.isEditable = false
        instructionsTextView.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        instructionsTextView.backgroundColor =  .systemGray5
        return instructionsTextView
    }()

    private var food: Food

    init(food: Food) {
        self.food = food
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension FoodDetailsViewController: ViewCode {
    func buildViewHierarch() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(ingredientsTitleLabel)
        contentView.addSubview(ingredientsTextView)
        contentView.addSubview(instructionsTitleLabel)
        contentView.addSubview(instructionsTextView)

        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 200),

            nameLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            ingredientsTitleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            ingredientsTextView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 5),
            ingredientsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ingredientsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsTextView.bottomAnchor, constant: 10),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            instructionsTextView.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 5),
            instructionsTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            instructionsTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            instructionsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func additionalConfiguration() {
        foodImageView.sd_setImage(with: URL(string: food.thumb))
        nameLabel.text = food.name
        categoryLabel.text = food.category
        ingredientsTextView.text = food.ingredients?.joined(separator: "\n")
        instructionsTextView.text = food.instructions
    }
}
