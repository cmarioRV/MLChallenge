//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Moya

struct NetworkManager: Networkable {
    var service = MoyaProvider<Service>()
    let decoder = JSONDecoder()
    
    func getSearch(query: String, completion: @escaping ([ItemDetailResponse]?, Error?) -> Void) -> Moya.Cancellable {
        return service.request(.search(query: query)) { result in
            switch result {
            case let .success(response):
                if response.statusCode >= 200 && response.statusCode < 300 {
                    do {
                        let response = try decoder.decode(SearchResponse.self, from: response.data)
                        completion(response.results, nil)
                    } catch let error {
                        completion(nil, error)
                    }
                }
                else {
                    do {
                        let error = try decoder.decode(ServerError.self, from: response.data)
                        completion(nil, error)
                    } catch let error {
                        completion(nil, error)
                    }
                }

            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
