//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation
import Moya
import Core

enum Service {
    case search(query: String)
}

extension Service: TargetType {
    var baseURL: URL {
        return AppConfiguration.Api.baseURL
    }
    
    var path: String {
        switch self {
        case .search:
            return "/sites/\(AppConfiguration.siteId)/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(query: let query):
            return .requestParameters(parameters: ["q": query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
}
