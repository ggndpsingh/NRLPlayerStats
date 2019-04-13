//
//  API.swift
//
//  Created by Gagandeep Singh on 25/2/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import Alamofire

/// Implement the APIHost protocol to create a new host to be used for API requests
protocol APIHost {
    var hostName: String { get }
    var baseURLComponents: URLComponents { get }
}

/// Implement the API protocol to set all the base properties of all possible API requests
protocol API {
    var host: APIHost { get }
    var sessionManager: SessionManager { get }
    func urlComponents(for endpoint: Endpoint) -> URLComponents
}

extension API {
    /// Make the API request and return the reponse as Result
    ///
    /// - Parameters:
    ///     - endpoint: The endpoint to be called
    ///     - completion: The completion handler block to be run after the request completes
    ///
    /// We are using the Result type here, new in Swift 5.
    /// We need to use Swift.Result because Alamofire has its own Result type and the two can clash.
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Swift.Result<T, APIError>) -> Void) {
        let builder = APIRequestBuilder(api: self, endpoint: endpoint)
        
        switch endpoint.requestType {
        case .data:
            sessionManager.request(builder).response { response in
                guard let data = response.data else {
                    return completion(.failure(.invalidRequest(builder: builder)))
                }
                
                guard let responseObject: T = try? T.decode(from: data) else {
                    return completion(.failure(.responseSerializationFailure))
                }
                
                completion(.success(responseObject))
            }
        }
    }
}
