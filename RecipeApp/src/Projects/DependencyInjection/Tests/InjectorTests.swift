//
//
//  Created by Vitor Conceicao.
//
//  github.com/vitor-rc1
//
//

import Testing
import DependencyInjection
import DependencyInjectionInterfaces

@Suite("DependencyInjector Tests")
final class DependencyInjectorTests {
    
    @Test("Test synchronous registration and resolution")
    func testSyncRegistrationAndResolution() {
        let injector = Injector()
        
        injector.register(TestService.self) { _ in
            MockService()
        }
        
        let service: TestService = injector.resolve()
        #expect(service.value == "test")
    }
    
    
    @Test("Test nested dependency resolution")
    func testNestedResolution() {
        let injector = Injector()
        
        injector.register(TestService.self) { _ in
            MockService()
        }
        
        injector.register(DependentService.self) { resolver in
            MockDependentService(testService: resolver.resolve())
        }
        
        let service: DependentService = injector.resolve()
        #expect(service.testService.value == "test")
    }
}
