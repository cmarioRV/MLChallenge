//
//  MainFactory.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Swinject

protocol MainFactory {
    func instantiateSearchViewController() -> SearchViewController
    func instantiateDetailViewController() -> DetailViewController
}

extension Container: MainFactory {
    func instantiateSearchViewController() -> SearchViewController {
        return resolve(SearchViewController.self)!
    }
    
    func instantiateDetailViewController() -> DetailViewController {
        return resolve(DetailViewController.self)!
    }
}
