//
//  FoodSearchBarProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 12/06/22.
//

import Foundation

protocol FoodSearchBarDelegate: AnyObject {
    func didClickRandomButton()
    func didClickSearchButton(type: FoodSearchType, searchText: String)
}
