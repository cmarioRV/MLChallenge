//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Swinject
import Core

class NetworkingAssembly: ModuleAssembly {
    var delegate: ModuleAssemblyDelegate?
    
    public func assemble(container: Container) {
        container.register(Networkable.self) { _ in
            NetworkManager()
        }.inObjectScope(.container)
    }
    
    func loaded(resolver: Resolver) {
        delegate?.loadedAssemblies(resolver: resolver)
    }
}
