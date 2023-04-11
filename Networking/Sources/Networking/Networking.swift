//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Moya
import Domain

protocol Networkable {
    var service: MoyaProvider<Service> { get }
    @discardableResult
    func getSearch(query: String, completion: @escaping ([ItemDetailResponse]?, Error?) -> Void) -> Cancellable
}
