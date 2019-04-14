//
//  StatsAPI.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 11/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import Alamofire

struct StatsAPI: API {
    private static let userKeyQueryItem = URLQueryItem(name: "userkey", value: "A00239D3-45F6-4A0A-810C-54A347F144C2")
    static let `default` = StatsAPI()
    
    let host: APIHost = StatsAPIHost()
    let sessionManager: SessionManager = SessionManager(configuration: URLSessionConfiguration.default)
    
    /// This is where a bit of the magic happens.
    /// The API & Endpoint join hands to generate the URL we need for our request.
    func urlComponents(for endpoint: Endpoint) -> URLComponents {
        var components = host.baseURLComponents
        components.path = components.path.stringByAppendingPathComponent(endpoint.path)
        components.queryItems = endpoint.queryItems
        
        // Add the userKey to the query
        components.queryItems?.append(StatsAPI.userKeyQueryItem)
        
        return components
    }
}

extension StatsAPI {
    // Normally this will live in its own API and loader,
    // but for the purpose of this project, async image view takes care of most of the work.
    static func getMediaUrl(playerId: Int) -> URL? {
        var urlString = "https://media.foxsports.com.au/match-centre/includes/images/headshots/nrl"
        urlString = urlString.stringByAppendingPathComponent("\(playerId)")
        urlString = urlString.appendPathExtension("jpg") ?? ""
        return URL(string: urlString)
    }
}
