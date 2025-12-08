//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import NetworkingInterfaces

import Foundation
import UIKit

enum FoodDetailsState {
    case loading
    case loaded
    case failure(String)
}

final class FoodDetailsViewModel {
    private let networkService: NetworkServiceProtocol
    private let endpoint: FoodDetailsEndpoint
    private let decodeType: FoodProtocol.Type

    var navigation: FoodDetailsNavigation?
    weak var viewController: FoodDetailsViewControllerProtocol?

    init(networkService: NetworkServiceProtocol,
         endpoint: FoodDetailsEndpoint,
         decodeType: FoodProtocol.Type) {
        self.networkService = networkService
        self.endpoint = endpoint
        self.decodeType = decodeType
    }
}

extension FoodDetailsViewModel: FoodDetailsViewModelProtocol {
    func fetchFoodDetails() async {
        
    }
}
