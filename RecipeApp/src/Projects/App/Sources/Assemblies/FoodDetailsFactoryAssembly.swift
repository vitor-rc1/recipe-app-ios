//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import DependencyInjectionInterfaces
import NetworkingInterfaces
import Networking

import Foundation
import UIKit

public struct FoodDetailsFactoryAssembly {
    private let injector: DependencyInjector

    public init(injector: DependencyInjector) {
        self.injector = injector
    }

    public func register() {
        injector.register(FoodDetailsFactoryProtocol.self) { _ in
            return FoodDetailsFactory()
        }
    }
}
