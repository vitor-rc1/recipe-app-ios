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
    
    public func register<Service, Argument>(
        _ serviceType: Service.Type,
        factory: @escaping (DependencyResolver, Argument) -> Service
    ) {
        container.register(serviceType) { [unowned self] (_, arg: Argument) in
            factory(self, arg)
        }
    }
    
    public func resolve<Service>() -> Service {
        guard let service = container.synchronize().resolve(Service.self) else {
            fatalError("Dependency Error: No service of type \(Service.self) was registered.")
        }
        
        return service
    }
    
    public func resolve<Service, Argument>(
        _ serviceType: Service.Type,
        argument: Argument
    ) -> Service {
        guard let service = getSynchonizedResolver().resolve(Service.self, argument: argument) else {
            fatalError("Dependency Error: No service of type \(Service.self) was registered.")
        }
        
        return service
    }
    
    private func getSynchonizedResolver() -> Resolver {
        return container.synchronize()
    }
}
