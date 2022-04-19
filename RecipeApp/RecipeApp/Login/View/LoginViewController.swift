//
//  LoginViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 06/04/22.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: Properties
    private var viewModel: LoginViewModelProtocol

    init(viewModel: LoginViewModelProtocol = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
        self.viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: IBActions
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }

        viewModel.login(email: email, password: password)
        let foodTab = FoodTabBarController()
        foodTab.modalPresentationStyle = .fullScreen
        show(foodTab, sender: nil)
    }

}

extension LoginViewController: LoginViewModelDelegateProtocol {
    func didSuccessLogin() {
    }
}
