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
        
        // Act
        sut.loginButton(button)
        
        // Assert
        XCTAssertTrue((viewModel as! LoginViewModelInputSpy).loginIsCalled)
        XCTAssertEqual((viewModel as! LoginViewModelInputSpy).email, sut.emailTextField.text)
        XCTAssertEqual((viewModel as! LoginViewModelInputSpy).password, sut.passwordTextField.text)
    }
    
    func makeSut() -> (LoginViewController, LoginViewModelProtocol) {
        let viewMNodel = LoginViewModelInputSpy()
        let viewController = LoginViewController(viewModel: viewMNodel)
        _ = viewController.view
        return (viewController, viewMNodel)
    }

}

class LoginViewModelInputSpy : LoginViewModelProtocol {
    var delegate: LoginViewModelDelegateProtocol?
    
    var loginIsCalled = false
    var email = String()
    var password = String()
    
    func login(email: String, password: String) {
        loginIsCalled = true
        self.email = email
        self.password = password
    }
}
