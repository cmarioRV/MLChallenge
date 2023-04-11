//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Moya
import Swinject
import Core
import Domain
import NetworkingInterface

public final class NetworkingModule: NetworkingModuleInterface {
    public var moduleAssembly: ModuleAssembly
    private var resolver: Resolver?
    
    public init(assembly: ModuleAssembly?) {
        if let assembly = assembly {
            self.moduleAssembly = assembly
        } else {
            self.moduleAssembly = NetworkingAssembly()
        }
        
        self.moduleAssembly.delegate = self
    }
    
    public convenience init() {
        self.init(assembly: nil)
    }
    
    public func loadedAssemblies(resolver: Resolver) {
        self.resolver = resolver
    }
    
    @discardableResult
    public func getSearch(query: String, completion: @escaping ([ItemDetail]?, Error?) -> Void) -> Moya.Cancellable? {
        guard let provider = resolver?.resolve(Networkable.self) else {
            completion(nil, nil)
            return nil
        }
        
        return provider.getSearch(query: query, completion: { response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let response = response else {
                completion(nil, nil)
                return
            }
            
            completion(response.compactMap { $0.toDomainModel() }, nil)
        })
    }
}
