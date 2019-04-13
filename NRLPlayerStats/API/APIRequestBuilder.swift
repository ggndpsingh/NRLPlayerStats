//
//  APIRequestBuilder.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 25/2/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import Alamofire

/// Simple type that implements `URLRequestConvertible`
/// and is passed to the Alamofire request methods.
/// This is the bit that adds `API` to `Endpoint` and returns a `URLRequest`
struct APIRequestBuilder: URLRequestConvertible {
    let api: API
    let endpoint: Endpoint
    
    func asURLRequest() throws -> URLRequest {
        guard let url = api.urlComponents(for: endpoint).url else {
            throw APIError.invalidRequest(builder: self)
        }
        
        // Normally this wouldn't be required,
        // but the semi-colons in the endpoint are tripping up the service request.
        guard
            let decodedUrlString = url.absoluteString.removingPercentEncoding,
            let decodedURL = URL(string: decodedUrlString) else {
                throw APIError.invalidRequest(builder: self)
        }
        
        var request = URLRequest(url: decodedURL)
        request.httpMethod = endpoint.method.rawValue
        return try endpoint.configure(request)
    }
}
