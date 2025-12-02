//
//  FoodDetailsCoordinatorTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 19/06/22.
//

import XCTest
@testable import App

class FoodDetailsCoordinatorTests: XCTestCase {
    func test_start_prepareFoodTabBar_when_called() throws {
        let meal = try XCTUnwrap(FoodMocks.shared.mockMeal().first)
        let sut = makeSut(food: meal)

        sut.start()

        let navController = try XCTUnwrap(sut.navigationController as? NavigationControllerSpy)

        XCTAssertTrue(navController.pushViewControllerDidCalled)
        XCTAssertTrue(navController.viewController is FoodDetailsViewController)
    }
    
    func makeSut(food: Food) -> FoodDetailsCoordinator<Meals> {
        return FoodDetailsCoordinator<Meals>(navCon: NavigationControllerSpy(),
                                             food: food)
    }
}
