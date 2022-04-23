//
//  FoodCollectionViewControllerTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 10/04/22.
//

import XCTest
@testable import RecipeApp

final class FoodCollectionViewControllerTests: XCTestCase {

    func test_foodViewController_should_call_loadFood_when_viewDidLoad() throws {
        let (_, viewModel) = makeSut()
        let foodViewModel = try XCTUnwrap(viewModel as? FoodViewModelSpy)
        XCTAssertTrue(foodViewModel.loadFoodIsCalled)
    }

    func test_foodViewController_should_return_empty_cell_when_dont_have_data() {
        let (sut, _) = makeSut()

        let emptyCell = sut.collectionView.cell(at: 0)

        XCTAssertTrue(emptyCell is EmptyCollectionViewCell)
    }

    func test_foodViewController_should_return_food_cell_when_load_data() throws {
        let (sut, _) = makeSut()
        let recipes = ["Chicken", "Cherry Pie", "Donuts"]
        sut.recipes = recipes
        sut.collectionView.reloadData()

        let foodCell = try XCTUnwrap(sut.collectionView.cell(at: 0) as? FoodCollectionViewCell)

        XCTAssertTrue(type(of: foodCell) == FoodCollectionViewCell.self)
        XCTAssertEqual(foodCell.label.text, recipes[0])
    }

    func makeSut() -> (FoodViewController, FoodViewModelProtocol) {
        let viewModel = FoodViewModelSpy()
        let sut = FoodViewController(viewModel: viewModel)
        _ = sut.view
        return (sut, viewModel)
    }
}

final class FoodViewModelSpy: FoodViewModelProtocol {
    weak var delegate: FoodViewModelDelegateProtocol?

    var loadFoodIsCalled = false
    func loadFood() {
        loadFoodIsCalled = true
    }
}

private extension UICollectionView {
    func cell(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: 0, section: 0))
    }
}