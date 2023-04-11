//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Swinject
import Core

class FakeNetworkingAssembly: ModuleAssembly {
    var delegate: ModuleAssemblyDelegate?
    
    public func assemble(container: Container) {
        container.register(Networkable.self) { _ in
            FakeNetworkManager()
        }.inObjectScope(.container)
    }
    
    func loaded(resolver: Resolver) {
        delegate?.loadedAssemblies(resolver: resolver)
    }
}
