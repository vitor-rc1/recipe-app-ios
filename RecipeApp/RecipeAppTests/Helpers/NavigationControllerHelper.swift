//
//  NavigationControllerHelper.swift
//  RecipeAppTests
//
//  Created by Vitor Conceicao on 23/04/22.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    var viewController: UIViewController?
    
    var pushViewControllerDidCalled = false
    var presentDidCalled = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerDidCalled = true
        self.viewController = viewController
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentDidCalled = true
        self.viewController = viewControllerToPresent
    }
}
