//
//  LoginViewModel.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 10/04/22.
//

import Foundation

class LoginViewModel {
    
}

extension LoginViewModel : LoginViewModelInputProtocol {
    func login(email: String, password: String, callback: (() -> Void)?) {
        print("Opa")
    }
}
