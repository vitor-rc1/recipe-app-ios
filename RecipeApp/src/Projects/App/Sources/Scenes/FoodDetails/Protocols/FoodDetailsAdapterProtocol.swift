//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

protocol FoodDetailsAdapterProtocol {
    func adapt(foodData: Data) throws -> FoodDetailsProtocol
}
