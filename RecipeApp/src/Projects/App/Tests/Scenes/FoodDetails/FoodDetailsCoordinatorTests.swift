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
        let (sut, navController) = makeSut(food: meal)

        sut.start()

        XCTAssertTrue(navController.pushViewControllerDidCalled)
    }
}

extension FoodDetailsCoordinatorTests {
    typealias SutAndDoubless = (
        sut: FoodDetailsCoordinator,
        navigationControllerSpy: NavigationControllerSpy
    )

    func makeSut(food: Food) -> SutAndDoubless {
        let navConSpy = NavigationControllerSpy()
        return (
            FoodDetailsCoordinator(navCon: navConSpy,
                                   foodDetailsViewController: UIViewController()),
            navConSpy
        )
    }
}
