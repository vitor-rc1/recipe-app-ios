//
//  FoodSearchBar.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 05/06/22.
//

import UIKit

class FoodSearchBar: UICollectionReusableView {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var searchButton: UIButton = {
        let searchButton = UIButton(configuration: .filled(), primaryAction: nil)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(didClickSearchButton), for: .touchUpInside)
        return searchButton
    }()

    private lazy var randomButton: UIButton = {
        let randomButton = UIButton(configuration: .tinted(), primaryAction: nil)
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        randomButton.setTitle("Random", for: .normal)
        randomButton.addTarget(self, action: #selector(didClickRandomButton), for: .touchUpInside)
        return randomButton
    }()

    private lazy var radioButtonsList: RadioButtonsList = {
        let radioButton = RadioButtonsList(titles: ["First letter", "Ingredient", "Name"])
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()

    weak var delegate: FoodSearchBarDelegate?
    private var searchText: String = String()
    private var searchType: FoodSearchType = .foodByName

    convenience init() {
        self.init(frame: .zero)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didClickRandomButton() {
        delegate?.didClickRandomButton()
    }

    @objc func didClickSearchButton() {
        delegate?.didClickSearchButton(type: searchType, searchText: searchText)
    }

}

extension FoodSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        radioButtonsList.cleanRadiosState()
        searchType = .foodByName
        searchBar.text = String()
        searchText = String()
        delegate?.didClickSearchButton(type: searchType, searchText: searchText)
    }
}

extension FoodSearchBar: RadioButtonsListDelegate {
    func radioSelected(title: String?) {
        if let title = title {
            searchType = FoodSearchType(rawValue: title) ?? .foodByName
        }
    }
}

extension FoodSearchBar: ViewCode {
    func buildViewHierarch() {
        addSubview(searchBar)
        addSubview(searchButton)
        addSubview(randomButton)
        addSubview(radioButtonsList)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

            radioButtonsList.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            radioButtonsList.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            radioButtonsList.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            searchButton.topAnchor.constraint(equalTo: radioButtonsList.bottomAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            randomButton.topAnchor.constraint(equalTo: radioButtonsList.bottomAnchor, constant: 10),
            randomButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)

        ])
    }

    func additionalConfiguration() {
        searchBar.delegate = self
        radioButtonsList.delegate = self
    }
}
