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
        foodImageView.contentMode = .scaleAspectFit
        return foodImageView
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 20)
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

    private lazy var ingredientsStackView: UIStackView = {
        let ingredientsStackView = UIStackView()
        ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
        ingredientsStackView.axis = .vertical
        ingredientsStackView.distribution = .fill
        ingredientsStackView.alignment = .leading
        ingredientsStackView.spacing = 3
        ingredientsStackView.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        return ingredientsStackView
    }()

    private lazy var instructionsTitleLabel: UILabel = {
        let instructionssLabel = UILabel()
        instructionssLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionssLabel.text = "Instructions"
        instructionssLabel.font = .systemFont(ofSize: 20)
        return instructionssLabel
    }()

    private lazy var instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.textColor = .black
        instructionsLabel.font = .systemFont(ofSize: 13)
        instructionsLabel.numberOfLines = 0
        instructionsLabel.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
        return instructionsLabel
    }()

    private var viewModel: FoodDetailsViewModelProtocol?
    private var food: Food?

    convenience init(viewModel: FoodDetailsViewModelProtocol) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel?.getFoodById()
    }

    private func setupIngredients(_ ingredients: [String]?) {
        ingredients?.forEach { ingredient in
            let ingredientLabel = UILabel()
            ingredientLabel.text = ingredient
            ingredientLabel.font = .systemFont(ofSize: 15)
            ingredientLabel.textColor = .black

            ingredientsStackView.addArrangedSubview(ingredientLabel)
        }
    }
}

extension FoodDetailsViewController: FoodDetailsDelegateProtocol {
    func didLoadFood(food: Food) {
        foodImageView.sd_setImage(with: URL(string: food.thumb))
        nameLabel.text = food.name
        categoryLabel.text = food.category
        setupIngredients(food.ingredients)
        instructionsLabel.text = food.instructions
    }
    func didFailFood() {}
}

extension FoodDetailsViewController: ViewCode {
    func buildViewHierarch() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(ingredientsTitleLabel)
        contentView.addSubview(ingredientsStackView)
        contentView.addSubview(instructionsTitleLabel)
        contentView.addSubview(instructionsLabel)

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
            foodImageView.heightAnchor.constraint(equalToConstant: 150),

            nameLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            ingredientsTitleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            ingredientsStackView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 5),
            ingredientsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ingredientsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsStackView.bottomAnchor, constant: 10),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            instructionsLabel.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 5),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func additionalConfiguration() {
        view.backgroundColor = .white
    }
}
