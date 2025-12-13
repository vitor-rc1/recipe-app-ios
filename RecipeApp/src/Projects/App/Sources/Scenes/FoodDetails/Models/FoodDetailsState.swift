//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

enum FoodDetailsState {
    case initial
    case loading
    case loaded(FoodDetailsProtocol)
    case failure(String)
}
