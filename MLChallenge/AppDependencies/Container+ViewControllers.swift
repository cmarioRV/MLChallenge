//
//  Container+ViewControllers.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import UIKit
import Swinject

extension Container {
    func registerViewControllers() {
        register(SearchViewController.self) {r in SearchViewController()}
            .initCompleted { (r, vc) in
                vc.viewModel = r.resolve(SearchViewModelType.self)
            }
        
        register(DetailViewController.self) {r in DetailViewController()}
            .initCompleted { (r, vc) in
                vc.viewModel = r.resolve(DetailViewModelType.self)
            }
    }
}
