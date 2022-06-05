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
        self.wait(for: [expectation], timeout: 0.1)
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
        self.wait(for: [expectation], timeout: 0.1)
    }
    
//    func test_getFood_should_return_mealById() throws {
//        let sut = makeSut()
//
//        let expectation = self.expectation(description: "Get meal by id")
//        registerMock(urlString: FoodAPI.meal.foodById(id: "52772"), mockFileName: "Meal", statusCode: 200)
//        sut.getFoodAPIData(url: FoodAPI.meal.foodById(id: "52772"), type: Meals.self) { result in
//            switch result {
//            case .success(let data):
//                XCTAssertEqual(data.meals?.count, 1)
//                XCTAssertEqual(data.meals?.first?.id, "52772")
//            default:
//                XCTFail("Failed to get meal")
//            }
//            expectation.fulfill()
//        }
//        self.wait(for: [expectation], timeout: 0.1)
//    }
//
//    func test_getFood_should_return_drinkByName() throws {
//        let api = FoodAPI.drink
//        let sut = makeSut(type: Drinks.self, api: api)
//
//        let expectation = self.expectation(description: "Get drink by name")
//        registerMock(urlString: api.foodByName(name: "Margarita"), mockFileName: "Drink", statusCode: 200)
//        sut.getFoodAPIData { result in
//            switch result {
//            case .success(let data):
//                XCTAssertEqual(data.drinks?.count, 1)
//                XCTAssertEqual(data.drinks?.first?.name, "Margarita")
//            default:
//                XCTFail("Failed to get drinks")
//            }
//            expectation.fulfill()
//        }
//        self.wait(for: [expectation], timeout: 0.1)
//    }
    
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
