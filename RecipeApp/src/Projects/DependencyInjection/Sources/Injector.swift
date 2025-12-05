//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation
import Swinject
import DependencyInjectionInterfaces

public final class Injector: DependencyInjector {
    private let container: Container
    
    public init() {
        self.container = Container()
    }
    
    public func register<Service>(_ serviceType: Service.Type,
                                  factory: @escaping (DependencyResolver) -> Service) {
        container.register(serviceType) { [unowned self] _ in
            factory(self)
        }
    }
    
    public func resolve<Service>() -> Service {
        guard let service = container.synchronize().resolve(Service.self) else {
            fatalError("Dependency Error: No service of type \(Service.self) was registered.")
        }
        return service
    }
}
