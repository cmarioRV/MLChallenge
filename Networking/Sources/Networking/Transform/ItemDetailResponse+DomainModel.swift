//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Domain
import Core

extension ItemDetailResponse: DTOMapper {
    public func toDomainModel() -> ItemDetail? {
        return ItemDetail(title: title, imageUrl: URL(string: imageUrlString), price: price, condition: condition, sellerReputation: getSellerReputation(from: sellerReputation))
    }
    
    private func getSellerReputation(from reputationResponse: String?) -> SellerReputation? {
        guard let reputationResponse = reputationResponse else { return nil }
        return SellerReputation(rawValue: reputationResponse)
    }
}
