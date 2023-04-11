//
//  Container+RegisterRouter.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import UIKit
import Swinject

extension Container {
    func registerRouter(root: UINavigationController) {
        register(RouterProtocol.self) {_ in Router(rootController: root)}
    }
}
