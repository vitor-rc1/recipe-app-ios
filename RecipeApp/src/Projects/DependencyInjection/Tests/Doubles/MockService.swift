//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//
    
import Foundation

protocol TestService {
    var value: String { get }
}

struct MockService: TestService {
    let value: String = "test"
}
