//
//  StatLoader.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

struct StatLoader<T: Decodable> {
    private let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func request(completion: @escaping (Result<T, APIError>) -> Void) {
        StatsAPI.default.request(endpoint, completion: completion)
    }
}
