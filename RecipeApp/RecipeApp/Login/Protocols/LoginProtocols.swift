//
//  LoginProtocols.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 08/04/22.
//

import Foundation

protocol LoginViewModelProtocol {
    var delegate: LoginViewModelDelegateProtocol? { get set }
    var loginNavigation: LoginNavigation? { get set }

    func login(email: String, password: String)
}

protocol LoginViewModelDelegateProtocol: AnyObject {
    func didSuccessLogin()
}

protocol LoginNavigation: AnyObject {
    func goToHome()
    func goToRegisterPage()
}