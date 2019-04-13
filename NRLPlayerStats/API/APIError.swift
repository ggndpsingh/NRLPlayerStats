//
//  APIError.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 25/2/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

/// Global error enum for the API
///
/// - invalidRequest: couldn't build a request
/// - responseSerializationFailure: response serialization failed
enum APIError: Error, CustomStringConvertible {
    case invalidRequest(builder: APIRequestBuilder)
    case responseSerializationFailure
    
    public var description: String {
        switch self {
        case .invalidRequest:
            return "invalidRequest"
        case .responseSerializationFailure:
            return "responseSerializationFailure"
        }
    }
}

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, .invalidRequest):
            return true
            
        case (.responseSerializationFailure, .responseSerializationFailure):
            return true
            
        default:
            return false
        }
    }
}
