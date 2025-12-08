//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import NetworkingInterfaces

import Foundation

struct DrinkDetailsEndpoint: FoodDetailsEndpoint {
    let baseURL: String = ProcessInfo.processInfo.environment["DRINK_BASE_URL"] ?? ""
    let id: String
}

struct MealDetailsEndpoint: FoodDetailsEndpoint {
    let baseURL: String = ProcessInfo.processInfo.environment["MEAL_BASE_URL"] ?? ""
    let id: String
}

protocol FoodDetailsEndpoint: APIEndpointProtocol {
    var id: String { get }
}

extension FoodDetailsEndpoint {
    var method: HTTPMethod {
        .get
    }

    var path: String {
        "/lookup.php?i=\(id)"
    }
}
