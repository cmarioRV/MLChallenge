//
//  DetailViewModel.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

internal protocol DetailViewModelInputs {
}

internal protocol DetailViewModelOutputs {
}

internal protocol DetailViewModelType {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}

internal final class DetailViewModel: DetailViewModelType, DetailViewModelInputs, DetailViewModelOutputs
{
    var inputs: DetailViewModelInputs { return self }
    var outputs: DetailViewModelOutputs { return self }
}
