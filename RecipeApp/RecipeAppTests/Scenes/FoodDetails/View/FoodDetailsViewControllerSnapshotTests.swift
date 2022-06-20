//
//  FoodDetailsViewControllerSnapshotTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 19/06/22.
//

import XCTest
import SnapshotTesting
import SDWebImageMockPlugin
@testable import RecipeApp

class FoodDetailsViewControllerSnapshotTests: XCTestCase {
    
    var imageMocker = ImageCacheMocker()

    override func setUp() {
        super.setUp()
        imageMocker.setupSDWebImageMocking()
    }
    
    func test_should_show_details() throws {
        URL.imageMock(named: "drink", inBundleID: "main")
        let food = try XCTUnwrap(FoodMocks.shared.mockMeal().first)
        let sut = makeSut(food: food)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func makeSut(food: Food) -> FoodDetailsViewController {
        return FoodDetailsViewController(food: food)
    }
}
