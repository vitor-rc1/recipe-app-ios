//
//  LoginProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 08/04/22.
//

import Foundation

protocol LoginViewModelProtocol {
    func login(email: String, password: String)
}

protocol LoginViewModelDelegateProtocol {
    func didSuccessLogin()
}
