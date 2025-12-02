//
//  FoodSearchBarSnapshotTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 19/06/22.
//

import XCTest
import SnapshotTesting
@testable import App

class FoodSearchBarTests: XCTestCase {
    func test_should_call_didClickRandomButton() throws {
        let (sut, delegate) = makeSut()
        let randomButtonAction = try XCTUnwrap(sut.subviews[2] as? UIButton)
            .actions(forTarget: sut, forControlEvent: .touchUpInside)?.first
        sut.performSelector(onMainThread: Selector(try XCTUnwrap(randomButtonAction)), with: nil, waitUntilDone: true)
        XCTAssertTrue(delegate.didClickRandomButtonCalled)
    }
    
    func test_should_call_didClickSearchButton() throws {
        let (sut, delegate) = makeSut()
        let searchButtonAction = try XCTUnwrap(sut.subviews[1] as? UIButton)
            .actions(forTarget: sut, forControlEvent: .touchUpInside)?.first
        sut.performSelector(onMainThread: Selector(try XCTUnwrap(searchButtonAction)), with: nil, waitUntilDone: true)
        XCTAssertTrue(delegate.didClickSearchButtonCalled)
    }
    
    func makeSut() -> (FoodSearchBar, FoodSearchBarDelegateSpy) {
        let sut = FoodSearchBar()
        let delegate = FoodSearchBarDelegateSpy()
        sut.delegate = delegate
        sut.frame = CGRect(x: 0, y: 0, width: 414, height: 150)
        return (sut, delegate)
    }
}

final class FoodSearchBarDelegateSpy: FoodSearchBarDelegate {
    var didClickRandomButtonCalled = false
    func didClickRandomButton() {
        didClickRandomButtonCalled = true
    }
    
    var didClickSearchButtonCalled = false
    func didClickSearchButton(type: FoodSearchType, searchText: String) {
        didClickSearchButtonCalled = true
    }
}
