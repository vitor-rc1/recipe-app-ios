//
//  FoodViewModelTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
@testable import RecipeApp

final class FoodViewModelTests: XCTestCase {

    func test_loadFood_loaded_foods_with_success() throws {
        let (sut, delegate, service) = makeSut()

        sut.loadFood()

        let delegateSpy = try XCTUnwrap(delegate as? FoodViewModelDelegateMock)
        XCTAssertTrue(delegateSpy.isDidLoadedFoodCalled)
        XCTAssertEqual(delegateSpy.foods.count, 4)
        XCTAssertEqual(delegateSpy.foods.first?.id, "52772")
        XCTAssertTrue((try XCTUnwrap(service as? FoodServiceMock)).isGetFoodCalled)
    }

    func makeSut() -> (FoodViewModel,
                       FoodViewModelDelegateProtocol,
                       FoodServiceProtocol) {
        let service = FoodServiceMock()
        let delegate = FoodViewModelDelegateMock()
        let sut = FoodViewModel(foodNavigation: FoodNavigationSpy(),
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
    var foods: [Meal] = []

    func didLoadedFood(foods: [Meal]) {
        isDidLoadedFoodCalled = true
        self.foods = foods
    }

    func didFailLoadedFood() { }
}

final class FoodServiceMock: FoodServiceProtocol {
    func getFood<T>(url: FoodAPI, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        isGetFoodCalled = true
        let foods = FoodMocks.shared.mockMeals() as? [T] ?? []
//        completion(.success(Meals() as? T.init()))
    }
    
    func getFood<T: Codable>(type: T.Type, completion: (Result<[T], Error>) -> Void) {
        isGetFoodCalled = true
        let foods = FoodMocks.shared.mockMeals() as? [T] ?? []
        completion(.success(foods))
    }
    
    var isGetFoodCalled = false
}
