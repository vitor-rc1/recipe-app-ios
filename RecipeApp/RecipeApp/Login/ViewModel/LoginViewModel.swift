//
//  LoginViewModel.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    weak var delegate: LoginViewModelDelegateProtocol?
    weak var loginNavigation: LoginNavigation?

    init(loginNavigation: LoginNavigation?) {
        self.loginNavigation = loginNavigation
    }

    func login(email: String, password: String) {
        loginNavigation?.goToHome()
    }
}
