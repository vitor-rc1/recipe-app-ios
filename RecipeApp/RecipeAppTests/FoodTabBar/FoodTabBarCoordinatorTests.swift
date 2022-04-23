//
//  FoodTabBarCoordinatorTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
@testable import RecipeApp

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

        XCTAssertEqual(foodTabBarControllers?.count, 4)
        XCTAssertEqual(foodTabBarControllers?.first?.tabBarItem.title, "Foods")
        XCTAssertEqual(foodTabBarControllers?[1].tabBarItem.title, "Explore foods")
        XCTAssertEqual(foodTabBarControllers?[2].tabBarItem.title, "Drinks")
        XCTAssertEqual(foodTabBarControllers?[3].tabBarItem.title, "Profile")
    }

    func makeSut() -> FoodTabBarCoordinator {
        return FoodTabBarCoordinator(navCon: NavigationControllerSpy())
    }
}
