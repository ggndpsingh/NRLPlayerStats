//
//  LeagueStat.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 11/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

struct LeagueStat: Codable {
    let matchId: String
    let teamA: Team
    let teamB: Team
    let type: StatType
    
    private enum CodingKeys: String, CodingKey {
        case matchId = "match_id"
        case teamA = "team_A"
        case teamB = "team_B"
        case type = "stat_type"
    }
}

extension LeagueStat {
    struct Team: Codable {
        let id: Int
        let name: String
        let code: String
        let shortName: String
        let topPlayers: [Player]
        
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case code
            case shortName = "short_name"
            case topPlayers = "top_players"
        }
    }
}

extension LeagueStat.Team {
    struct Player: Codable {
        let id: Int
        let position: String
        let name: String
        let shortName: String
        let statValue: Int
        let jumperNumber: Int
        
        private enum CodingKeys: String, CodingKey {
            case id
            case position
            case name = "full_name"
            case shortName = "short_name"
            case statValue = "stat_value"
            case jumperNumber = "jumper_number"
        }
    }
}

extension LeagueStat {
    enum StatType: String, Codable {
        case tackles
        case runs
        case fantasyPoints = "fantasy_points"
        case runMeters = "run_metres"
    }
}
