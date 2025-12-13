
//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import NetworkingInterfaces

import UIKit

protocol FoodDetailsFactoryProtocol {
    func make(foodId: String,
              foodType: FoodType,
              navigationController: UINavigationController) -> any Coordinator
}
