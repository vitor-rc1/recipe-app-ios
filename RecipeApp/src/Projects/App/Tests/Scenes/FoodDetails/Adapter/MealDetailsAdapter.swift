//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Testing
@testable import App

@Suite("MealDetailsAdapter Tests")
struct MealDetailsAdapterTests {

    let adapter = MealDetailsAdapter()

    @Test("GIVEN valid meals JSON data WHEN adapt is called THEN returns MealDetail")
    func testAdaptWithValidData() throws {
        // Given
        let jsonString = """
        {
            "meals": [
                {
                    "idMeal": "52772",
                    "strMeal": "Teriyaki Chicken Casserole",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
                    "strCategory": "Chicken",
                    "strInstructions": "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\\r\\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\\r\\nMeanwhile, steam or boil carrots and broccoli until tender crisp, about 5-7 minutes and drain. Spread rice and veggies evenly on bottom of baking pan.\\r\\nPlace chicken on top and season with salt and pepper.\\r\\nPour sauce over chicken and veggies. Bake 35 minutes, remove from oven.\\r\\nSprinkle with sesame seeds and bake for another 5-10 minutes until chicken is cooked through and sauce has thickened."
                }
            ]
        }
        """
        let data = jsonString.data(using: .utf8)!

        // When
        let result = try adapter.adapt(foodData: data)

        // Then
        #expect(result is MealDetail)
        let meal = result as! MealDetail
        #expect(meal.id == "52772")
        #expect(meal.name == "Teriyaki Chicken Casserole")
        #expect(meal.thumb == "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg")
        #expect(meal.category == "Chicken")
        #expect(meal.instructions?.starts(with: "Preheat oven to 350° F.") == true)
        #expect(meal.ingredients.isEmpty) // As per implementation
    }

    @Test("GIVEN meals JSON with empty array WHEN adapt is called THEN throws ServiceError.decodeFail")
    func testAdaptWithEmptyMeals() throws {
        // Given
        let jsonString = """
        {
            "meals": []
        }
        """
        let data = jsonString.data(using: .utf8)!

        // When & Then
        #expect(throws: ServiceError.decodeFail("No meal details found")) {
            try adapter.adapt(foodData: data)
        }
    }

    @Test("GIVEN meals JSON with null meals WHEN adapt is called THEN throws ServiceError.decodeFail")
    func testAdaptWithNullMeals() throws {
        // Given
        let jsonString = """
        {
            "meals": null
        }
        """
        let data = jsonString.data(using: .utf8)!

        // When & Then
        #expect(throws: ServiceError.decodeFail("No meal details found")) {
            try adapter.adapt(foodData: data)
        }
    }

    @Test("GIVEN invalid JSON data WHEN adapt is called THEN throws DecodingError")
    func testAdaptWithInvalidData() throws {
        // Given
        let data = "invalid json".data(using: .utf8)!

        // When & Then
        #expect(throws: DecodingError.self) {
            try adapter.adapt(foodData: data)
        }
    }
}
