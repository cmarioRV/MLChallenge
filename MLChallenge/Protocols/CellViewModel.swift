//
//  CellViewModel.swift
//  MLChallenge
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

protocol CellViewModel {}

protocol ViewModelPressible {
    var cellPressed: (()->Void)? { get set }
}
