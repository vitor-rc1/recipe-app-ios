//
//  LoginViewController.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 06/04/22.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Properties
    private let viewModel: LoginViewModelInputProtocol
    
    init(viewModel: LoginViewModelInputProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: IBActions
    @IBAction func loginButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.login(email: email,
                        password: password,
                        callback: nil)
    }
    
}
