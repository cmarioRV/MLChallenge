//
//  Container+Modules.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Swinject
import Networking
import NetworkingInterface

extension Container {
    func registerModules() {
        register(NetworkingModuleInterface.self) { r in NetworkingModule() }.inObjectScope(.container)
        
        let assemblies: [Assembly] = [resolve(NetworkingModuleInterface.self)!.moduleAssembly]
        let _ = Assembler(assemblies, container: self)
    }
}
