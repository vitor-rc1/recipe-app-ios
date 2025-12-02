//
//  FoodTabBarCoordinatorTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
@testable import App

final class FoodTabBarCoordinatorTests: XCTestCase {

    func test_start_prepareFoodTabBar_when_called() throws {
        let sut = makeSut()

        sut.start()

        let navController = try XCTUnwrap(sut.navigationController as? NavigationControllerSpy)

        XCTAssertTrue(navController.pushViewControllerDidCalled)
        XCTAssertTrue(navController.viewController is FoodTabBarController)
    }

    func test_foodTabBarController_should_have_correct_controllers() throws {
        let sut = makeSut()

        sut.start()

        let navController = try XCTUnwrap(sut.navigationController as? NavigationControllerSpy)
        let foodTabBarControllers = try XCTUnwrap(navController.viewController as? FoodTabBarController).viewControllers

        XCTAssertEqual(foodTabBarControllers?.count, 2)
        XCTAssertEqual(foodTabBarControllers?.first?.tabBarItem.title, "Foods")
        XCTAssertEqual(foodTabBarControllers?[1].tabBarItem.title, "Drinks")
    }

    func makeSut() -> FoodTabBarCoordinator {
        return FoodTabBarCoordinator(navCon: NavigationControllerSpy())
    }
}
