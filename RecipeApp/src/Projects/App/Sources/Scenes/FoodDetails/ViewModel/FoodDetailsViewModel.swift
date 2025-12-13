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
    case loaded(FoodDetailsProtocol)
    case failure(String)
}

final class FoodDetailsViewModel {
    private let networkService: NetworkServiceProtocol
    private let endpoint: FoodDetailsEndpoint
    private let detailsAdapter: FoodDetailsAdapterProtocol
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
         detailsAdapter: FoodDetailsAdapterProtocol) {
        self.networkService = networkService
        self.endpoint = endpoint
        self.detailsAdapter = detailsAdapter
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

    private func loadFood() async throws -> FoodDetailsProtocol {
        let (data, httpUrlResponse) = try await networkService.request(endpoint: endpoint)
        switch httpUrlResponse.statusCode {
        case 200...299:
            return try detailsAdapter.adapt(foodData: data)
        default:
            throw ServiceError.network("Failed to load food details.\nStatus code: \(httpUrlResponse.statusCode)")
        }
    }
}
