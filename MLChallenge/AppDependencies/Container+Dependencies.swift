//
//  Container+Dependencies.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import UIKit
import Swinject

extension Container {
    func registerDependencies(rootViewController: UINavigationController) {
        registerCoordinators()
        registerViewModels()
        registerViewControllers()
        registerRouter(root: rootViewController)
        registerModules()
    }
}
