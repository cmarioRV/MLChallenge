//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Moya

struct FakeNetworkManager: Networkable {
    var service = MoyaProvider<Service>()
    
    func getSearch(query: String, completion: @escaping ([ItemDetailResponse]?, Error?) -> Void) -> Moya.Cancellable {
        let response = [
            ItemDetailResponse(title: "Item 1", imageUrlString: "http://url.com", price: 1, condition: "new", sellerReputation: "5_green"),
            ItemDetailResponse(title: "Item 2", imageUrlString: "http://url.com", price: 2, condition: "new", sellerReputation: "4_light_green"),
            ItemDetailResponse(title: "Item 3", imageUrlString: "http://url.com", price: 3, condition: "used", sellerReputation: "3_yellow")
        ]
        completion(response, nil)
        return CancellableToken { }
    }
}
