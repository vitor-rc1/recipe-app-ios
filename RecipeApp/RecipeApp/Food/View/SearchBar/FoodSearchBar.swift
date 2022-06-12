//
//  FoodSearchBar.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 05/06/22.
//

import UIKit

class FoodSearchBar: UIView {
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    private lazy var searchButton: UIButton = {
        let searchButton = UIButton(type: .system)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(didClickSearchButton), for: .touchUpInside)
        return searchButton
    }()

    private lazy var randomButton: UIButton = {
        let randomButton = UIButton(type: .system)
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        randomButton.setTitle("Random", for: .normal)
        randomButton.addTarget(self, action: #selector(didClickRandomButton), for: .touchUpInside)
        return randomButton
    }()

    weak var delegate: FoodSearchBarDelegate?
    private var searchText: String = String()

    convenience init() {
        self.init(frame: .zero)
        setUp()
    }

    @objc func didClickRandomButton() {
        delegate?.didClickkRandomButton()
    }

    @objc func didClickSearchButton() {
        delegate?.didClickSearchButton(type: .foodByName, searchText: searchText)
    }

}

extension FoodSearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
}

extension FoodSearchBar: ViewCode {
    func buildViewHierarch() {
        addSubview(searchBar)
        addSubview(searchButton)
        addSubview(randomButton)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

            searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            searchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            randomButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            randomButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            randomButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func additionalConfiguration() {
        backgroundColor = UIColor.white
        searchBar.delegate = self
    }
}
