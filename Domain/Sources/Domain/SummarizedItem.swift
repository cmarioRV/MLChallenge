//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

public struct SummarizedItem {
    public let title: String
    public let imageUrl: URL
    
    public init(title: String, imageUrl: URL) {
        self.title = title
        self.imageUrl = imageUrl
    }
}
