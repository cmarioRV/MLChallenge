//
//  SearchViewModel.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Domain
import NetworkingInterface
import Moya

internal protocol SearchViewModelInputs {
    func search(query: String)
    func getItem(at index: Int)
}

internal protocol SearchViewModelOutputs {
    var cellViewModels: Bind<[SearchTableViewCell.ViewModel]> { get }
    var error: Bind<Error?> { get }
    var isBussy: Bind<Bool> { get }
    var itemDetail: Bind<ItemDetail?> { get }
}

internal protocol SearchViewModelType {
    var inputs: SearchViewModelInputs { get }
    var outputs: SearchViewModelOutputs { get }
}

internal final class SearchViewModel: SearchViewModelType, SearchViewModelInputs, SearchViewModelOutputs
{
    var inputs: SearchViewModelInputs { return self }
    var outputs: SearchViewModelOutputs { return self }
    
    var error = Bind<Error?>(nil)
    var isBussy = Bind<Bool>(false)
    var cellViewModels = Bind<[SearchTableViewCell.ViewModel]>([SearchTableViewCell.ViewModel]())
    var itemDetail = Bind<ItemDetail?>(nil)
    private let networkingProvider: NetworkingModuleInterface
    private var cancellable: Cancellable?
    
    private var results: [ItemDetail] = []
    
    init(networkingProvider: NetworkingModuleInterface) {
        self.networkingProvider = networkingProvider
    }
    
    func search(query: String) {
        if let cancellable = cancellable {
            cancellable.cancel()
        }
        
        if !isBussy.value {
            isBussy.value = true
        }
        
        cancellable = networkingProvider.getSearch(query: query) { [weak self] results, error in
            guard let self = self else { return }
            
            guard let results = results else {
                self.error.value = error
                self.isBussy.value = false
                return
            }
            
            self.results = results
            self.cellViewModels.value = results.map{ .init(image: $0.imageUrl, title: $0.title)  }
            self.isBussy.value = false
        }
    }
    
    func getItem(at index: Int) {
        if results.count > index {
            itemDetail.value = results[index]
        }
    }
}
