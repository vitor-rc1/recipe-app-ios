//
//  NavigationControllerHelper.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    var pushViewControllerDidCalled = false
    var viewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerDidCalled = true
        self.viewController = viewController
    }
}
