//
//  FoodCollectionViewControllerTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 10/04/22.
//

import XCTest
@testable import App

final class FoodCollectionViewControllerTests: XCTestCase {

    func test_foodViewController_should_return_loading_cell_when_load_for_first_time() throws {
        let (sut, _) = makeSut(isLoadFoods: false)

        let loadingCell = try XCTUnwrap((sut.collectionView.cell(at: 0)))

        XCTAssertTrue(type(of: loadingCell) == LoadingCollectionViewCell.self)
    }
    
    func test_foodViewController_should_return_empty_cell_when_viewDidDisappear() throws {
        let (sut, _) = makeSut(isLoadFoods: false)
        
        sut.viewDidDisappear(true)

        let emptyCell = try XCTUnwrap(sut.collectionView.cell(at: 0, section: 2) as? EmptyCollectionViewCell)

        XCTAssertTrue(type(of: emptyCell) == EmptyCollectionViewCell.self)
    }

    func test_foodViewController_should_return_food_cell_when_load_data() throws {
        let foods = FoodMocks.shared.mockMeals().map { Food($0) }
        let (sut, viewModel) = makeSut(foods: foods)
        let recipes = FoodMocks.shared.mockMeals()

        let foodCell = try XCTUnwrap(sut.collectionView.cell(at: 0, section: 1) as? FoodCollectionViewCell)
        
        let cellFoodNameTextView = foodCell.subviews.first?.subviews.filter({ view in
            view is UITextView
        }).first as? UITextView
        
        XCTAssertTrue(type(of: foodCell) == FoodCollectionViewCell.self)
        XCTAssertEqual(recipes[0].name, cellFoodNameTextView?.text)
        XCTAssertTrue(viewModel.loadFoodIsCalled)
    }
    
    func test_foodViewController_should_return_empty_cell_when_load_data() throws {
        let (sut, viewModel) = makeSut()

        let emptyCell = try XCTUnwrap(sut.collectionView.cell(at: 0, section: 2) as? EmptyCollectionViewCell)
        
        let emptyCellLabel = emptyCell.subviews.filter({ view in
            view is UILabel
        }).first as? UILabel
        
        XCTAssertTrue(type(of: emptyCell) == EmptyCollectionViewCell.self)
        XCTAssertEqual("Oops!\nRecipes not found.", emptyCellLabel?.text)
        XCTAssertTrue(viewModel.loadFoodIsCalled)
    }
    
    func test_foodViewController_should_call_didFailLoadedFood() {
        let (_, viewModel) = makeSut(isLoadFoods: false, returnError: true)
        
        XCTAssertTrue(viewModel.loadFoodIsCalled)
    }

    func makeSut(isLoadFoods: Bool = true, returnError: Bool = false, foods: [Food] = []) -> (FoodViewController, FoodViewModelMock) {
        let viewModel = FoodViewModelMock(isLoadFoods: isLoadFoods, returnError: returnError, foods: foods)
        let sut = FoodViewController(viewModel: viewModel)
        viewModel.delegate = sut
        _ = sut.view
        return (sut, viewModel)
    }
}

final class FoodViewModelMock: FoodViewModelProtocol {
    weak var foodNavigation: FoodNavigation?
    weak var delegate: FoodViewModelDelegateProtocol?
    var service: FoodServiceProtocol
    let isLoadFoods: Bool
    let returnError: Bool
    let foods: [Food]
    
    init(isLoadFoods: Bool, returnError: Bool, foods: [Food]) {
        service = FoodServiceMock(isSuccessLoad: true)
        self.isLoadFoods = isLoadFoods
        self.foods = foods
        self.returnError = returnError
    }

    var loadFoodIsCalled = false
    func loadFood() {
        loadFoodIsCalled = true
        if isLoadFoods {
            delegate?.didLoadedFood(foods: foods)
        } else if returnError{
            delegate?.didFailLoadedFood(title: "Error", error: "Error on load food")
        }
    }
    
    var randomFoodCalled = false
    func randomFood() {
        randomFoodCalled = true
    }
    
    var searchFoodCalled = false
    func searchFood(type: FoodSearchType, searchText: String) {
        searchFoodCalled = true
    }
    
    var didTapFoodCellCalled = false
    func didTapFoodCell(id: String) {
        didTapFoodCellCalled = true
    }
}

private extension UICollectionView {
    func cell(at row: Int, section: Int = 0) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: row, section: section))
    }
}
