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
        let sut = makeSut()

        let expectation = self.expectation(description: "Get meals")
        registerMock(urlString: FoodAPI<Meals>.foods.apiURL, mockFileName: "Meals", statusCode: 200)
        sut.getFoodAPIData(url: FoodAPI<Meals>.foods, type: Meals.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.meals?.count, 25)
                XCTAssertEqual(data.meals?.first?.id, "52977")
                XCTAssertEqual(data.meals?.last?.id, "52931")
            default:
                XCTFail("Failed to get meals")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getFood_should_return_drinks() throws {
        let sut = makeSut()
        
        let expectation = self.expectation(description: "Get drinks")
        registerMock(urlString: FoodAPI<Drinks>.foods.apiURL, mockFileName: "Drinks", statusCode: 200)
        sut.getFoodAPIData(url: FoodAPI<Drinks>.foods, type: Drinks.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.drinks?.count, 25)
                XCTAssertEqual(data.drinks?.first?.id, "15997")
                XCTAssertEqual(data.drinks?.last?.id, "11872")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func test_getFood_should_return_mealById() throws {
        let sut = makeSut()

        let expectation = self.expectation(description: "Get meal by id")
        registerMock(urlString: FoodAPI<Meals>.foodById(id: "52772").apiURL, mockFileName: "Meal", statusCode: 200)
        sut.getFoodAPIData(url: FoodAPI<Meals>.foodById(id: "52772"), type: Meals.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.meals?.count, 1)
                XCTAssertEqual(data.meals?.first?.id, "52772")
            default:
                XCTFail("Failed to get meal")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }

    func test_getFood_should_return_drinkByName() throws {
        let sut = makeSut()

        let expectation = self.expectation(description: "Get drink by name")
        registerMock(urlString: FoodAPI<Drinks>.foodByName(name: "Margarita").apiURL, mockFileName: "Drink", statusCode: 200)
        sut.getFoodAPIData(url: FoodAPI<Drinks>.foodByName(name: "Margarita"), type: Drinks.self) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.drinks?.count, 1)
                XCTAssertEqual(data.drinks?.first?.name, "Margarita")
            default:
                XCTFail("Failed to get drinks")
            }
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 0.1)
    }
    
    func makeSut() -> FoodService {
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let sessionManager = Alamofire.Session(configuration: configuration)
        let service = FoodService(sessionManager: sessionManager)
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
