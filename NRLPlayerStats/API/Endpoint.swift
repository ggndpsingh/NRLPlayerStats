//
//  Endpoint.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 25/2/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import Alamofire

/// Implement this protocol to define an API endpoint (`API` + `Enpoint` = `URLRequest`)
/// These are the bits that are different between each endpoint including:
/// - `path` the URL path
/// - `method` the http method
/// - `requestType` a data, download, or upload request
/// - `queryItems` query items that get appended to the url
/// - `configure(_ urlRequest: URLRequestConvertible) throws -> URLRequest` a custom method to allow you to configure the URL request before it gets sent (e.g. encode parameters)
protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var requestType: RequestType { get }
    var queryItems: [URLQueryItem] { get }
    func configure(_ urlRequest: URLRequestConvertible) throws -> URLRequest
}

// There could be more request types such as download or upload requests
enum RequestType {
    case data
}
