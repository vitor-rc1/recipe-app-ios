//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Testing
@testable import App

@Suite("DrinksDetailsAdapter Tests")
struct DrinksDetailsAdapterTests {

    let adapter = DrinksDetailsAdapter()

    @Test("GIVEN valid drinks JSON data WHEN adapt is called THEN returns DrinkDetail")
    func testAdaptWithValidData() throws {
        // Given
        let jsonString = """
        {
            "drinks": [
                {
                    "idDrink": "11007",
                    "strDrink": "Margarita",
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg",
                    "strAlcoholic": "Alcoholic",
                    "strInstructions": "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.",
                    "ingredients": []
                }
            ]
        }
        """
        let data = jsonString.data(using: .utf8)!

        // When
        let result = try adapter.adapt(foodData: data)

        // Then
        #expect(result is DrinkDetail)
        let drink = result as! DrinkDetail
        #expect(drink.id == "11007")
        #expect(drink.name == "Margarita")
        #expect(drink.thumb == "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg")
        #expect(drink.category == "Alcoholic")
        #expect(drink.instructions == "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.")
        #expect(drink.ingredients.isEmpty) // Since ingredients are not in JSON
    }

    @Test("GIVEN drinks JSON with empty array WHEN adapt is called THEN throws ServiceError.decodeFail")
    func testAdaptWithEmptyDrinks() throws {
        // Given
        let jsonString = """
        {
            "drinks": []
        }
        """
        let data = jsonString.data(using: .utf8)!

        // When & Then
        #expect(throws: ServiceError.decodeFail("No drinks details found")) {
            try adapter.adapt(foodData: data)
        }
    }

    @Test("GIVEN drinks JSON with null drinks WHEN adapt is called THEN throws ServiceError.decodeFail")
    func testAdaptWithNullDrinks() throws {
        // Given
        let jsonString = """
        {
            "drinks": null
        }
        """
        let data = jsonString.data(using: .utf8)!

        // When & Then
        #expect(throws: ServiceError.decodeFail("No drinks details found")) {
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
    

