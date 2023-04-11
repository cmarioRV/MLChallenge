//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

public protocol Module: ModuleAssemblyDelegate {
    var moduleAssembly: ModuleAssembly { get }
    init(assembly: ModuleAssembly?)
}
