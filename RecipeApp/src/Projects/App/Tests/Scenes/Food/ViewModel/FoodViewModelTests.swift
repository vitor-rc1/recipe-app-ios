//
//  FoodViewModelTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
import Alamofire
@testable import App

final class FoodViewModelTests: XCTestCase {

    func test_loadFood_loaded_foods_with_success() {
        let (sut, delegate, service, _) = makeSut()

        sut.loadFood()

        XCTAssertTrue(delegate.didLoadedFoodCalled)
        XCTAssertEqual(delegate.foods.count, 4)
        XCTAssertEqual(delegate.foods.first?.id, "52772")
        XCTAssertTrue(service.getFoodCalled)
    }
    
    func test_loadFood_should_call_didFailLoadedFood() {
        let (sut, delegate, service, _) = makeSut(isSuccess: false)

        sut.loadFood()
        
        XCTAssertTrue(delegate.didFailLoadedFoodCalled)
        XCTAssertEqual(delegate.errorTitle, "Error on load foods.")
        XCTAssertEqual(delegate.errorMessage, "Load Food error.")
        XCTAssertTrue(service.getFoodCalled)
    }
    
    func test_randomFood_loaded_food_with_success() {
        let (sut, _, service, navigation) = makeSut()

        sut.randomFood()
        
        XCTAssertTrue(service.getRandomFoodCalled)
        XCTAssertTrue(navigation.goToFoodDetailCalled)
        XCTAssertEqual(navigation.food?.id, "52772")
    }
    
    func test_randomFood_should_call_didFailLoadedFood() {
        let (sut, delegate, service, _) = makeSut(isSuccess: false)

        sut.randomFood()
        
        XCTAssertTrue(delegate.didFailLoadedFoodCalled)
        XCTAssertEqual(delegate.errorTitle, "Error on load random food.")
        XCTAssertEqual(delegate.errorMessage, "Random Food load error.")
        XCTAssertTrue(service.getRandomFoodCalled)
    }
    
    func test_searchFood_loaded_food_with_success_when_type_is_foodByName() {
        let (sut, delegate, service, _) = makeSut()

        sut.searchFood(type: .foodByName, searchText: "Teriyaki Chicken Casserole")
        
        XCTAssertTrue(delegate.didLoadedFoodCalled)
        XCTAssertEqual(delegate.foods.count, 1)
        XCTAssertEqual(delegate.foods.first?.id, "52772")
        XCTAssertTrue(service.getFoodByNameCalled)
    }
    
    func test_searchFood_loaded_food_with_success_when_type_is_foodByIngredient() {
        let (sut, delegate, service, _) = makeSut()

        sut.searchFood(type: .foodByIngredient, searchText: "Vodka")
        
        XCTAssertTrue(delegate.didLoadedFoodCalled)
        XCTAssertEqual(delegate.foods.count, 4)
        XCTAssertEqual(delegate.foods.first?.id, "15997")
        XCTAssertTrue(service.getFoodsByIngredientCalled)
    }
    
    func test_searchFood_loaded_food_with_success_when_type_is_foodByFirstLetter() {
        let (sut, delegate, service, _) = makeSut()

        sut.searchFood(type: .foodByFirstLetter, searchText: "G")
        
        XCTAssertTrue(delegate.didLoadedFoodCalled)
        XCTAssertEqual(delegate.foods.count, 1)
        XCTAssertEqual(delegate.foods.first?.id, "15997")
        XCTAssertTrue(service.getFoodsByFirstLettterCalled)
    }
    
    func test_searchFood_loaded_food_with_error_when_type_is_foodByFirstLetter_and_two_letters() {
        let (sut, delegate, _, _) = makeSut(isSuccess: false)

        sut.searchFood(type: .foodByFirstLetter, searchText: "AS")
        
        XCTAssertTrue(delegate.didFailLoadedFoodCalled)
        XCTAssertEqual(delegate.errorTitle, "Validation error.")
        XCTAssertEqual(delegate.errorMessage, "Please insert one character for search by first letter")
    }
    
    func test_didTapFoodCell_loaded_food_with_success() {
        let (sut, _, service, navigation) = makeSut()

        sut.didTapFoodCell(id: "52772")

        XCTAssertTrue(service.getFoodByIdCalled)
        XCTAssertTrue(navigation.goToFoodDetailCalled)
        XCTAssertEqual(navigation.food?.id, "52772")
    }
    
    func test_didTapFoodCell_loaded_food_with_error() {
        let (sut, delegate, service, _) = makeSut(isSuccess: false)

        sut.didTapFoodCell(id: "52772")
        
        XCTAssertTrue(service.getFoodByIdCalled)
        XCTAssertTrue(delegate.didFailLoadedFoodCalled)
        XCTAssertEqual(delegate.errorTitle, "Error on load food by id.")
        XCTAssertEqual(delegate.errorMessage, "Load Food By Id error.")
    }

    func makeSut(isSuccess: Bool = true) -> (FoodViewModel,
                                                             FoodViewModelDelegateMock,
                                                             FoodServiceMock,
                                                             FoodNavigationSpy) {
        let service = FoodServiceMock(isSuccessLoad: isSuccess)
        let delegate = FoodViewModelDelegateMock()
        let navigation = FoodNavigationSpy()
        let sut = FoodViewModel(foodNavigation: navigation,
                                service: service)
        sut.delegate = delegate
        return (sut, delegate, service, navigation)
    }
}

final class FoodNavigationSpy: FoodNavigation {
    var food: Food?
    
    func goToFoodView() {}
    
    var goToFoodDetailCalled = false
    func goToFoodDetail(food: Food) {
        goToFoodDetailCalled = true
        self.food = food
    }
}

final class FoodViewModelDelegateMock: FoodViewModelDelegateProtocol {
    var didLoadedFoodCalled = false
    var didFailLoadedFoodCalled = false
    var foods: [Food] = []
    var errorMessage: String = String()
    var errorTitle: String = String()

    func didLoadedFood(foods: [Food]) {
        didLoadedFoodCalled = true
        self.foods = foods
    }

    func didFailLoadedFood(title: String, error: String) {
        didFailLoadedFoodCalled = true
        errorMessage = error
        errorTitle = title
    }
}

final class FoodServiceMock: FoodServiceProtocol {
    var sessionManager: Session?
    var isSuccessLoad: Bool
    
    init(isSuccessLoad: Bool) {
        self.isSuccessLoad = isSuccessLoad
    }
    var getFoodCalled = false
    func getFoods(completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        getFoodCalled = true
        if isSuccessLoad {
            let foods = FoodMocks.shared.mockMeals()
            let meals = Foods(foods: foods)
            completion(.success(meals))
        } else {
            completion(.failure(FoodViewModelCustomError.loadFood))
        }
    }
    
    var getFoodByIdCalled = false
    func getFoodById(id: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        getFoodByIdCalled = true
        if isSuccessLoad {
            let foods = FoodMocks.shared.mockMeal()
            let meal = Foods(foods: foods)
            completion(.success(meal))
        } else {
            completion(.failure(FoodViewModelCustomError.getFoodById))
        }
    }
    
    var getFoodByNameCalled = false
    func getFoodByName(name: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        getFoodByNameCalled = true
        let foods = FoodMocks.shared.mockMeal()
        let meals = Foods(foods: foods)
        completion(.success(meals))
    }
    
    var getFoodsByIngredientCalled = false
    func getFoodsByIngredient(ingredient: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        getFoodsByIngredientCalled = true
        let foods = FoodMocks.shared.mockDrinks()
        let drinks = Foods(foods: foods)
        completion(.success(drinks))
    }
    
    var getFoodsByFirstLettterCalled = false
    func getFoodsByFirstLettter(letter: String, completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        getFoodsByFirstLettterCalled = true
        let foods = FoodMocks.shared.mockDrink()
        let drink = Foods(foods: foods)
        completion(.success(drink))
    }
    
    var getRandomFoodCalled = false
    func getRandomFood(completion: @escaping (Result<FoodsProtocol, Error>) -> Void) {
        getRandomFoodCalled = true
        if isSuccessLoad {
            let foods = FoodMocks.shared.mockMeal()
            let meals = Foods(foods: foods)
            completion(.success(meals))
        } else {
            completion(.failure(FoodViewModelCustomError.randomFood))
        }
    }
}

private enum FoodViewModelCustomError: Error {
    case randomFood
    case loadFood
    case getFoodById
}

extension FoodViewModelCustomError: LocalizedError {
    public var errorDescription: String? {
            switch self {
            case .randomFood:
                return NSLocalizedString("Random Food load error.", comment: String())
            case .loadFood:
                return NSLocalizedString("Load Food error.", comment: String())
            case .getFoodById:
                return NSLocalizedString("Load Food By Id error.", comment: String())
            }
        }
}
