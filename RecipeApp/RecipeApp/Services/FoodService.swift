//
//  FoodService.swift
//  RecipeApp
//
//  Created by Vitor Conceicao on 23/04/22.
//

import Foundation
import Alamofire

final class FoodService: FoodServiceProtocol {
    private var sessionManager: Session?
    
    init(sessionManager: Session) {
        self.sessionManager = sessionManager
    }
    
    func getFood<T: Codable>(url: FoodAPI<T>, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        sessionManager?.request(url.apiURL)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let foods):
                    completion(.success(foods))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
