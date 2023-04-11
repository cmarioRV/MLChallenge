//
//  MainCoordinator.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Domain

class MainCoordinator: BaseCoordinator {
    var finishFlow: (() -> Void)?
    
    private let router: RouterProtocol
    private let factory: MainFactory
    
    init(router: RouterProtocol, factory: MainFactory) {
        self.router = router
        self.factory = factory
    }
    
    private func showSearchViewController() {
        let searchViewController = self.factory.instantiateSearchViewController()
        searchViewController.onShowDetail = { [unowned self] item in
            self.showDetailViewController(item: item)
        }
        self.router.setRootModule(searchViewController, hideBar: false)
    }
    
    private func showDetailViewController(item: ItemDetail) {
        let detailViewController = self.factory.instantiateDetailViewController()
        detailViewController.item = item
        self.router.push(detailViewController, animated: true)
    }
    
    override func start() {
        self.showSearchViewController()
    }
}

