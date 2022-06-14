//
//  FoodDetailsDelegateProtocol.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 13/06/22.
//

import Foundation

protocol FoodDetailsDelegateProtocol: AnyObject {
    func didLoadFood()
    func didFailFood()
}
