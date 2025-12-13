
//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

struct DrinksDetailsAdapter: FoodDetailsAdapterProtocol {
    func adapt(foodData: Data) throws -> any FoodDetailsProtocol {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(DrinksResponse.self, from: foodData)

        guard let mealDetail = decodedData.drinks?.first else {
            throw ServiceError.decodeFail("No drinks details found")
        }

        return mealDetail
    }
}
