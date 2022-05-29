//
//  FoodViewModelTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
import Alamofire
@testable import RecipeApp

final class FoodViewModelTests: XCTestCase {

    func test_loadFood_loaded_foods_with_success() throws {
        let (sut, delegate, service) = makeSut(type: Meals.self)

        sut.loadFood()

        let delegateSpy = try XCTUnwrap(delegate as? FoodViewModelDelegateMock)
        XCTAssertTrue(delegateSpy.isDidLoadedFoodCalled)
        XCTAssertEqual(delegateSpy.foods.count, 4)
        XCTAssertEqual(delegateSpy.foods.first?.id, "52772")
        XCTAssertTrue((try XCTUnwrap(service as? FoodServiceMock)).isGetFoodCalled)
    }

    func makeSut<FoodType: Codable>(type: FoodType.Type ) -> (FoodViewModel<FoodType>,
                       FoodViewModelDelegateProtocol,
                       FoodServiceProtocol) {
        let service = FoodServiceMock()
        let delegate = FoodViewModelDelegateMock()
        let sut = FoodViewModel<FoodType>(foodNavigation: FoodNavigationSpy(),
                                service: service)
        sut.delegate = delegate
        return (sut, delegate, service)
    }
}

final class FoodNavigationSpy: FoodNavigation {
    func goToFoodView() {}
}

final class FoodViewModelDelegateMock: FoodViewModelDelegateProtocol {
    var isDidLoadedFoodCalled = false
    var isDidFailLoadedFoodCalled = false
    var foods: [Food] = []

    func didLoadedFood(foods: [Food]) {
        isDidLoadedFoodCalled = true
        self.foods = foods
    }

    func didFailLoadedFood() { }
}

final class FoodServiceMock: FoodServiceProtocol {
    var sessionManager: Session?
    
    var isGetFoodCalled = false
    
    func getFoodAPIData<FoodType: Codable>(url: String,
                                    type: FoodType.Type,
                                    completion: @escaping (Result<FoodType, Error>) -> Void) {
        isGetFoodCalled = true
        let foods = FoodMocks.shared.mockMeals()
        let meals = Meals(meals: foods)
        completion(.success(meals as! FoodType))
    }
}
