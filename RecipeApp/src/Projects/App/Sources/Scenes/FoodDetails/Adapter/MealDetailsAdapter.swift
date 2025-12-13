//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

struct MealDetailsAdapter: FoodDetailsAdapterProtocol {
    func adapt(foodData: Data) throws -> any FoodDetailsProtocol {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(MealsResponse.self, from: foodData)

        guard let mealDetail = decodedData.meals?.first else {
            throw ServiceError.decodeFail("No meal details found")
        }

        return mealDetail
    }
}
