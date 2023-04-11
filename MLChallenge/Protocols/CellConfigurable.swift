//
//  CellConfigurable.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

protocol CellConfigurable {
    func configure(viewModel: CellViewModel)
}

extension CellConfigurable {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}
