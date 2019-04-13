//
//  StatsAPIHost.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 12/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

struct StatsAPIHost: APIHost {
    let hostName: String = "statsapi.foxsports.com.au"
    
    var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = hostName
        components.path = "/3.0/api/sports/league"
        return components
    }
}
