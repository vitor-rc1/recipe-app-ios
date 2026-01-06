//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import UIKit
@testable import App

final class FoodDetailsFactorySpy: FoodDetailsFactoryProtocol {
    enum Method {
        case make
    }

    var calledMethods: [Method] = []

    func make(foodId: String,
              foodType: FoodType,
              navigationController: UINavigationController) -> Coordinator {
        calledMethods.append(.make)
        return CoordinatorDummy()
    }
}
