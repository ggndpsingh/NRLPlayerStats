//
//  StatsEndpoint.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 11/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import Alamofire

enum StatsEndpoint: Endpoint {
    /// Endpoint for Match Stats.
    /// - Associalted Values:
    ///     - year: The year of the league.
    ///     - round: The round of the league.
    ///     - match: The match of the round.
    case match(Int, Int, Int)
    
    /// Endpoint for Player Stats.
    /// - Associalted Values:
    ///     - teamId: ID of the team to which the player belongs.
    ///     - playerId: ID of the player.
    case player(Int, Int)
    
    var path: String {
        switch self {
        case .match(let year, let round, let game):
            let matchId = """
            NRL\
            \(year)\
            \(String(int: round))\
            \(String(int: game))
            """
            
            return """
            /matches\
            /\(matchId)\
            /topplayerstats.json\
            ;type=fantasy_points\
            ;type=tackles\
            ;type=runs\
            ;type=run_metres
            """
            
        case .player(let teamId, let playerId):
            return """
            /series/1\
            /seasons/115\
            /teams\
            /\(teamId)\
            /players\
            /\(playerId)\
            /detailedstats.json
            """
        }
    }
    
    var requestType: RequestType {
        return .data
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .match:
            return [
                URLQueryItem(name: "limit", value: "5"),
            ]
            
        default:
            return []
        }
    }
    
    func configure(_ urlRequest: URLRequestConvertible) throws -> URLRequest {
        return try urlRequest.asURLRequest()
    }
}
