//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

protocol FoodDetailsProtocol: Codable {
    var id: String { get }
    var name: String { get }
    var thumb: String { get }
    var ingredients: [String] { get }
    var category: String? { get }
    var instructions: String? { get }
}
