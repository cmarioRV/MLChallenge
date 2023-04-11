//
//  File.swift
//  
//
//  Created by Mario Rúa on 10/04/23.
//

import Foundation

private enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

public enum AppConfiguration {
    public enum Api {
        public static var baseURL: URL {
            return try! URL(string: "https://" + Configuration.value(for: "API_BASE_URL"))!
        }
    }
    
    static var appName: String {
        return try! Configuration.value(for: "APP_NAME")
    }
    
    public static var siteId: String {
        return "MLA"
    }
}
