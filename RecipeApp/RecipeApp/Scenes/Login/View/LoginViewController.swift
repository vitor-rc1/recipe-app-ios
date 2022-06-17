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
    private var viewModel: LoginViewModelProtocol?

    convenience init(viewModel: LoginViewModelProtocol) {
        self.init(nibName: "LoginViewController", bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: IBActions
    @IBAction func loginButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }

        viewModel?.login(email: email, password: password)
    }

}

extension LoginViewController: LoginViewModelDelegateProtocol {
    func didSuccessLogin() {
    }
}
