//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Foundation

protocol DependentService {
    var testService: TestService { get }
}

struct MockDependentService: DependentService {
    let testService: TestService
}
