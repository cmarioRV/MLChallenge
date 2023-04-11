//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

public struct SearchResponse: Codable {
    public let results: [ItemDetailResponse]
}

public struct ItemDetailResponse {
    public let title: String
    public let imageUrlString: String
    public let price: Double
    public let condition: String
    public let sellerReputation: String?
}

extension ItemDetailResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case imageUrlString = "thumbnail"
        case price = "price"
        case condition = "condition"
        case sellerReputation = "seller_reputation"
    }
}
