//
//  CoordinatorFactory.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func instantiateAppCoordinator() -> AppCoordinator
    func instantiateMainCoordinator() -> MainCoordinator
}
