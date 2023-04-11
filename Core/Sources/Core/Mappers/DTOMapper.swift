//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

public protocol DTOMapper {
    associatedtype DomainModelType
    func toDomainModel() -> DomainModelType
}
