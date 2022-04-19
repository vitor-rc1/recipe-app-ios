//
//  FoodTabBarControllerTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 10/04/22.
//

import XCTest
@testable import RecipeApp

final class FoodTabBarControllerTests: XCTestCase {
    func test_when_initialized_did_call_FoodViewController() throws {
        let (sut) = makeSut()
        let selectedViewController = try XCTUnwrap(sut.selectedViewController as? FoodViewController)
        XCTAssertTrue(type(of: selectedViewController) == FoodViewController.self)
        XCTAssertEqual(selectedViewController.title, "Foods")
    }

    func makeSut() -> (FoodTabBarController) {
        let foddTabBarVC = FoodTabBarController(nibName: nil, bundle: nil)
        _ = foddTabBarVC.view
        return foddTabBarVC
    }
}
