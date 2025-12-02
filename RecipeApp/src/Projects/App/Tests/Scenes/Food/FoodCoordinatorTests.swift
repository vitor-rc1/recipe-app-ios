//
//  FoodCoordinatorTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 19/06/22.
//

import XCTest
@testable import App

class FoodCoordinatorTests: XCTestCase {
    func test_start_goToFoodView_when_called() throws {
        let sut = makeSut()

        sut.start()

        let navController = try XCTUnwrap(sut.navigationController as? NavigationControllerSpy)

        XCTAssertTrue(navController.pushViewControllerDidCalled)
        XCTAssertTrue(navController.viewController is FoodViewController)
    }
    
    func test_goToFoodDetail_append_foodTabBarCoordinator_when_called() throws {
        let sut = makeSut()
        let meal = try XCTUnwrap(FoodMocks.shared.mockMeal().first)
        
        sut.goToFoodDetail(food: meal)

        XCTAssertTrue(sut.children.first is FoodDetailsCoordinator<Meals>)
    }
    
    func makeSut() -> FoodCoordinator<Meals> {
        let foodApi = FoodAPI.meal
        let navigationController = NavigationControllerSpy()
        let sut = FoodCoordinator<Meals>(navCon: navigationController, api: foodApi)
        return sut
    }
}
