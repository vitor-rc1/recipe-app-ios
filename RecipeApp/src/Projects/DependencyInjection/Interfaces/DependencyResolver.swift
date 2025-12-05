//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//
    
import Foundation

public protocol DependencyResolver {
    func resolve<Service>() -> Service
}
