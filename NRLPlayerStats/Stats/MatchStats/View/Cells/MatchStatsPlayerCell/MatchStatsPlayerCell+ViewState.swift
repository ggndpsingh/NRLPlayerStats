//
//  MatchStatsPlayerCell+ViewState.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

extension MatchStatsPlayerCell {
    struct ViewState {
        let statType: LeagueStat.StatType
        let teamA: Int?
        let teamB: Int?
        let playerA: LeagueStat.Team.Player?
        let playerB: LeagueStat.Team.Player?
        
        init(
            statType: LeagueStat.StatType = .tackles,
            teams: (Int?, Int?) = (nil, nil),
            players: (LeagueStat.Team.Player?, LeagueStat.Team.Player?) = (nil, nil))
        {
            self.statType = statType
            self.teamA = teams.0
            self.teamB = teams.1
            self.playerA = players.0
            self.playerB = players.1
        }
    }
}
