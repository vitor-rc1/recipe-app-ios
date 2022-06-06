//
//  FoodServiceTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
import Mocker
import Alamofire
@testable import RecipeApp

final class FoodServiceTests: XCTestCase {
    func test_getFood_should_return_meals() throws {
        let api = FoodAPI.meal
        let sut = makeSut(type: Meals.self, api: api)

        let expectation = self.expectation(description: "Get meals")
        registerMock(urlString: api.foods(), mockFileName: "Meals", statusCode: 200)
        sut.getFoods { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 25)
                XCTAssertEqual(data.foods.first?.id, "52977")
                XCTAssertEqual(data.foods.last?.id, "52931")
            default:
                XCTFail("Failed to get meals")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.2)
    }
    
    func test_getFood_should_return_drinks() throws {
        let api = FoodAPI.drink
        let sut = makeSut(type: Drinks.self, api: api)
        
        let expectation = self.expectation(description: "Get drinks")
        registerMock(urlString: api.foods(), mockFileName: "Drinks", statusCode: 200)
        sut.getFoods { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 25)
                XCTAssertEqual(data.foods.first?.id, "15997")
                XCTAssertEqual(data.foods.last?.id, "11872")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.2)
    }
    
    func test_getFoodById_should_return_mealById() throws {
        let api = FoodAPI.drink
        let sut = makeSut(type: Meals.self, api: api)

        let expectation = self.expectation(description: "Get meal by id")
        registerMock(urlString: api.foodById(id: "52772"), mockFileName: "Meal", statusCode: 200)
        sut.getFoodById(id: "52772") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 1)
                XCTAssertEqual(data.foods.first?.id, "52772")
            default:
                XCTFail("Failed to get meal")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }

    func test_getFoodByName_should_return_drinkByName() throws {
        let api = FoodAPI.drink
        let sut = makeSut(type: Drinks.self, api: api)

        let expectation = self.expectation(description: "Get drink by name")
        registerMock(urlString: api.foodByName(name: "Margarita"), mockFileName: "Drink", statusCode: 200)
        sut.getFoodByName(name: "Margarita") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 1)
                XCTAssertEqual(data.foods.first?.name, "Margarita")
            default:
                XCTFail("Failed to get drinks")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getFoodsByFirstLetter_should_return_drinksByFirsLetter() throws {
        let api = FoodAPI.drink
        let sut = makeSut(type: Drinks.self, api: api)

        let expectation = self.expectation(description: "Get drinks by first letter")
        registerMock(urlString: api.foodsByFirstLettter(letter: "a"), mockFileName: "DrinksByFirstLetter", statusCode: 200)
        sut.getFoodsByFirstLettter(letter: "a") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 25)
                XCTAssertEqual(data.foods.first?.name, "A1")
                XCTAssertEqual(data.foods.last?.name, "After sex")
            default:
                XCTFail("Failed to get drinks")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getFooddByFirstLetter_should_return_drinksByFirsLetter() throws {
        let api = FoodAPI.drink
        let sut = makeSut(type: Drinks.self, api: api)

        let expectation = self.expectation(description: "Get drinks by ingredient")
        registerMock(urlString: api.foodsByIngredient(ingredient: "vodka"), mockFileName: "DrinksByIngredient", statusCode: 200)
        sut.getFoodsByIngredient(ingredient: "vodka") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 92)
                XCTAssertEqual(data.foods.first?.name, "155 Belmont")
                XCTAssertEqual(data.foods.last?.name, "Zorbatini")
            default:
                XCTFail("Failed to get drinks")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getRandomFood_should_return_mealById() throws {
        let api = FoodAPI.meal
        let sut = makeSut(type: Meals.self, api: api)

        let expectation = self.expectation(description: "Get random meal.")
        registerMock(urlString: api.randomFood(), mockFileName: "RandomMeal", statusCode: 200)
        sut.getRandomFood { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.foods.count, 1)
                XCTAssertEqual(data.foods.first?.id, "52908")
            default:
                XCTFail("Failed to get meal")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    
    func test_getfoods_should_not_return_meals() throws {
        let api = FoodAPI.meal
        let sut = makeSut(type: Meals.self, api: api)

        let expectation = self.expectation(description: "Get random meal.")
        registerMock(urlString: FoodAPI.drink.foodById(id: "1234"), mockFileName: "NotFound", statusCode: 200)
        sut.getFoodById(id: "1234") { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "URLSessionTask failed with error: The operation couldn’t be completed. (Mocker.MockingURLProtocol.Error error 0.)")
            default:
                XCTFail("Success to get meal")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func makeSut<FoodType: Codable>(type: FoodType.Type, api: FoodAPI) -> FoodService<FoodType> {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)
        let service = FoodService<FoodType>(sessionManager: sessionManager, api: api)
        return service
    }
    
    private func registerMock(urlString: String, mockFileName: String, statusCode: Int) {
            if let url = URL(string: urlString) {
                let mockResponse = FileManipulation.shared.loadJsonFile(name: mockFileName)
                let mockService = Mock(url: url, ignoreQuery: false, dataType: .json, statusCode: statusCode,
                                       data: [Mock.HTTPMethod.get : mockResponse])
                mockService.register()
            } else {
                XCTFail("Need a url to mock")
            }
        }
}

class FileManipulation {
    
    static let shared = FileManipulation()
    
    func loadJsonFile(name: String) -> Data {
        guard let dataURL = Bundle(for: type(of: self)).path(forResource: name, ofType: "json") else {
            fatalError("Could not find \(name).json")
        }
        
        guard let jsonString = try? String(contentsOfFile: dataURL, encoding: .utf8) else {
            fatalError("Unable to convert \(name).json to String")
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert string json to Data")
        }
        
        return jsonData
    }
}
