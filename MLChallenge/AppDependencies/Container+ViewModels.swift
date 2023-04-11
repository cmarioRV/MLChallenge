//
//  Container+ViewModels.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import NetworkingInterface
import Swinject

extension Container {
    func registerViewModels() {
        register(SearchViewModelType.self) {r in SearchViewModel(networkingProvider: r.resolve(NetworkingModuleInterface.self)!)}
        register(DetailViewModelType.self) {r in DetailViewModel()}
    }
}
