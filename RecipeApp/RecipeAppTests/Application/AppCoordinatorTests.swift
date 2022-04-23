//
//  AppCoordinatorTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
@testable import RecipeApp

final class AppCoordinatorTests: XCTestCase {

    func test_goToLoginPage_did_push_loginViewController() throws {
        let sut = makeSut()
        sut.goToLoginPage()

        let navController = try XCTUnwrap(sut.navigationController as? NavigationControllerSpy)

        XCTAssertTrue(navController.pushViewControllerDidCalled)
        XCTAssertTrue(navController.viewController is LoginViewController)
    }

    func test_goToHome_append_foodTabBarCoordinator_when_called() {
        let sut = makeSut()

        sut.goToHome()

        XCTAssertTrue(sut.children.first is FoodTabBarCoordinator)
    }

    func makeSut() -> AppCoordinator {
        return AppCoordinator(navCon: NavigationControllerSpy())
    }
}
