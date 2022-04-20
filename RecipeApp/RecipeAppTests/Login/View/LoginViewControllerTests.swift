//
//  LoginViewControllerTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 08/04/22.
//

import XCTest
@testable import RecipeApp

final class LoginViewControllerTests: XCTestCase {
    func test_login_did_called_with_correct_parameters() throws {
        // Arrange
        let (sut, viewModel) = makeSut()
        sut.emailTextField.text = "test@email.com"
        sut.passwordTextField.text = "123456"
        let button = UIButton()
        let loginViewModel = try XCTUnwrap(viewModel as? LoginViewModelInputSpy)

        sut.loginButton(button)

        XCTAssertTrue(loginViewModel.loginIsCalled)
        XCTAssertEqual(loginViewModel.email, sut.emailTextField.text)
        XCTAssertEqual(loginViewModel.password, sut.passwordTextField.text)
    }

    func makeSut() -> (LoginViewController, LoginViewModelProtocol) {
        let viewMNodel = LoginViewModelInputSpy()
        let viewController = LoginViewController(viewModel: viewMNodel)
        _ = viewController.view
        return (viewController, viewMNodel)
    }

}

class LoginViewModelInputSpy: LoginViewModelProtocol {
    weak var delegate: LoginViewModelDelegateProtocol?
    var loginNavigation: LoginNavigation?

    var loginIsCalled = false
    var email = String()
    var password = String()

    func login(email: String, password: String) {
        loginIsCalled = true
        self.email = email
        self.password = password
    }
}
