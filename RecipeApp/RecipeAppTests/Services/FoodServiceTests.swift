//
//  FoodServiceTests.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import XCTest
import Mocker
@testable import RecipeApp

final class FoodServiceTests: XCTestCase {
    func test_getFood_should_return_meals() throws {
        let sut = makeSut()

        let expectation = self.expectation(description: "Get meals")
        registerMock(urlString: FoodAPI.meals.apiURL, mockFileName: "Meals", statusCode: 200)
        sut.getFood(url: FoodAPI.meals, type: Meals.self) { result in
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
        self.wait(for: [expectation], timeout: 3)
    }
    
    func makeSut() -> FoodService {
        let service = FoodService()
        return service
    }
    
    private func registerMock(urlString: String, mockFileName: String, statusCode: Int) {
            if let url = URL(string: urlString) {
                let mockResponse = FileManipulation.shared.loadJsonFile(name: mockFileName)
                let mockService = Mock(url: url, ignoreQuery: true, dataType: .json, statusCode: statusCode,
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
