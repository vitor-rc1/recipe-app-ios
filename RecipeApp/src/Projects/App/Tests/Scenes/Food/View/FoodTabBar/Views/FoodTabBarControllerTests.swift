//
//  FoodTabBarControllerTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 10/04/22.
//

import XCTest
@testable import App

final class FoodTabBarControllerTests: XCTestCase {
    func test_when_initialized_did_call_FoodViewController() throws {
        let sut = makeSut()
        let selectedViewController = try XCTUnwrap(sut.selectedViewController as? UINavigationController)
        XCTAssertTrue(selectedViewController.viewControllers.first is CustomViewController)
        XCTAssertEqual(selectedViewController.viewControllers.first?.title, "Foods")
    }

    func makeSut() -> FoodTabBarController {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem(title: "Foods",
                                                     image: nil,
                                                     tag: 1)
        let viewController = CustomViewController()
        viewController.title = "Foods"
        navController.viewControllers = [viewController]
        let foddTabBarVC = FoodTabBarController(foodTabBarNavigation: nil, controllers: [navController])
        _ = foddTabBarVC.view
        return foddTabBarVC
    }
}

final class CustomViewController: UIViewController {}
