//
//  FoodCollectionViewControllerTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 10/04/22.
//

import XCTest
@testable import RecipeApp

class FoodCollectionViewControllerTests: XCTestCase {
    
    func test_foodCollectionView_should_return_empty_cell_when_dont_have_data() {
        let (sut) = makeSut()
        
        let emptyCell = sut.collectionView.cell(at: 0) as! EmptyCollectionViewCell
        
        XCTAssertTrue(type(of: emptyCell) == EmptyCollectionViewCell.self)
        XCTAssertEqual(emptyCell.cellLabel.text, "Oops! Recipes not found")
    }
    
    func makeSut() -> (FoodCollectionViewController) {
        let sut = FoodCollectionViewController(collectionViewLayout: UICollectionViewLayout())
        _ = sut.view
        return (sut)
    }

}

private extension UICollectionView {
    func cell(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: 0, section: 0))
    }
}
