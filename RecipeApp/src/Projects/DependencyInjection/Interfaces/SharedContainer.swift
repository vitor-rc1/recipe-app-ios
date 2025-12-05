//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//
    
import Foundation

public final class SharedContainer {
    public static let shared = SharedContainer()
    
    private var injector: DependencyInjector!
    
    private init() {}
    
    public func setInjector(_ injector: DependencyInjector) {
        self.injector = injector
    }
    
    public func resolver() -> DependencyResolver {
        guard let injector = injector else {
            fatalError("Dependency Error: Injector not set in SharedContainer.")
        }
        
        return injector
    }
}
