//
//  TestAPI.swift
//  NRLPlayerStatsTests
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import Alamofire
import Shawshank
@testable import NRLPlayerStats

struct TestHost: APIHost {
    let hostName: String = "test.statsapi.foxsports.com.au"
    
    var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = hostName
        return components
    }
}


struct TestAPI: API {
    let host: APIHost = TestHost()
    let sessionManager: SessionManager
    
    init() {
        let config = URLSessionConfiguration.default
        Shawshank.unbind().bind(config)
        sessionManager = SessionManager(configuration: config)
    }
    
    func urlComponents(for endpoint: Endpoint) -> URLComponents {
        var components = host.baseURLComponents
        components.path = components.path.stringByAppendingPathComponent(endpoint.path)
        return components
    }
}

enum TestEndpoint: Endpoint {
    case match
    case player
    
    var path: String {
        switch self {
        case .match:
            return "/match"
        case .player:
            return "/player"
        }
    }
    
    var requestType: RequestType {
        return .data
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    func configure(_ urlRequest: URLRequestConvertible) throws -> URLRequest {
        return try urlRequest.asURLRequest()
    }
}
