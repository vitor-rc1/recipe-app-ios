//
//  RadioButtonListSnapshotTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 19/06/22.
//

import XCTest
import SnapshotTesting
@testable import App

class RadioButtonListSnapshotTests: XCTestCase {

    func test_should_show_radio_button_list() {
        let (sut, _) = makeSut()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_should_select_radio_button_list() throws {
        let (sut, delegate) = makeSut()
        let radioAction = try XCTUnwrap(sut.subviews.first?.subviews.first as? UIButton)
            .actions(forTarget: sut, forControlEvent: .touchUpInside)?.first
        sut.performSelector(onMainThread: Selector(try XCTUnwrap(radioAction)), with: nil, waitUntilDone: true)
        XCTAssertTrue(delegate.radioSelectedCalled)
    }
    
    func makeSut() -> (RadioButtonsList, RadioButtonsListDelegateSpy) {
        let sut = RadioButtonsList(titles: ["First Letter", "Ingredient", "Name"])
        
        sut.frame = CGRect(x: 0, y: 0, width: 414, height: 20)
        sut.backgroundColor = .black
        let delegate = RadioButtonsListDelegateSpy()
        sut.delegate = delegate
        return (sut, delegate)
    }
}

final class RadioButtonsListDelegateSpy: RadioButtonsListDelegate {
    var radioSelectedCalled = false
    
    func radioSelected(title: String?) {
        radioSelectedCalled = true
    }
    
    
}
