//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import UIKit
@testable import App

final class CoordinatorDummy: Coordinator {
    var parentCoordinator: (Coordinator)? = nil
    var children: [Coordinator] = []
    var navigationController: UINavigationController = NavigationControllerSpy()

    func start() {}
}
