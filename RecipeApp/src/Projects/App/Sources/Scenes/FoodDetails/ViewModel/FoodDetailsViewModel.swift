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
    case initial
    case loading
    case loaded(FoodDetailProtocol)
    case failure(String)
}

final class FoodDetailsViewModel {
    private let networkService: NetworkServiceProtocol
    private let endpoint: FoodDetailsEndpoint
    private let decodeType: FoodDetailProtocol.Type
    private(set) var state: FoodDetailsState = .initial {
        didSet {
            Task { @MainActor in
                viewController?.stateDidChange(state: state)
            }
        }
    }

    var navigation: FoodDetailsNavigation?
    weak var viewController: FoodDetailsViewControllerProtocol?

    init(networkService: NetworkServiceProtocol,
         endpoint: FoodDetailsEndpoint,
         decodeType: FoodDetailProtocol.Type) {
        self.networkService = networkService
        self.endpoint = endpoint
        self.decodeType = decodeType
    }
}

extension FoodDetailsViewModel: FoodDetailsViewModelProtocol {
    func fetchFoodDetails() async {
        state = .loading

        do {
            let food = try await loadFood()
            state = .loaded(food)
        } catch {
            print(error)
            state = .failure(error.localizedDescription)
            return
        }
    }

    private func loadFood() async throws -> FoodDetailProtocol {
        let decoder = JSONDecoder()
        let (data, httpUrlResponse) = try await networkService.request(endpoint: endpoint)
        switch httpUrlResponse.statusCode {
        case 200...299:
            let result = try decoder.decode(decodeType.self, from: data)
            return result
        default:
            throw ServiceError.network("Failed to load food details.\nStatus code: \(httpUrlResponse.statusCode)")
        }
    }
}
