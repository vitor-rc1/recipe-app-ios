//
//  AppCoordinator.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 18/04/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func goToLoginPage()
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }

    func start() {
        goToLoginPage()
    }
}

extension AppCoordinator: LoginNavigation {
    // TODO: Gerar RegisterProtocol
    func goToRegisterPage() {}

    func goToLoginPage() {
        let loginViewModel = LoginViewModel(loginNavigation: self)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginViewModel.delegate = loginViewController

        navigationController.pushViewController(loginViewController, animated: true)
    }

    func goToHome() {
        let foodTabBarController = FoodTabBarController(nibName: "FoodTabBarController", bundle: nil)

        navigationController.pushViewController(foodTabBarController, animated: true)
    }
}
