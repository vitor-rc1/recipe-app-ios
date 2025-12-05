//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//
    
import Foundation

public protocol DependencyInjector: DependencyResolver {
    func register<Service>(
        _ serviceType: Service.Type,
        factory: @escaping (DependencyResolver) -> Service
    )
}
