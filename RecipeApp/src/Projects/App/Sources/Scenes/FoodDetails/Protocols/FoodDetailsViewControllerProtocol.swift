//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

protocol FoodDetailsViewControllerProtocol: AnyObject {
    @MainActor func stateDidChange(state: FoodDetailsState)
}
