//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

public struct ItemDetail {
    public let title: String
    public let imageUrl: URL?
    public let price: Double
    public let condition: String
    public let sellerReputation: SellerReputation?
    
    public init(title: String, imageUrl: URL?, price: Double, condition: String, sellerReputation: SellerReputation?) {
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.condition = condition
        self.sellerReputation = sellerReputation
    }
}
