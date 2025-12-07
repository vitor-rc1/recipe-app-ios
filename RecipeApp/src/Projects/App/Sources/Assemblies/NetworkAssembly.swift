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

public struct NetworkAssembly {
    private let injector: DependencyInjector

    public init(injector: DependencyInjector) {
        self.injector = injector
    }

    public func register() {
        injector.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }
    }
}
