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
        let playerA: LeagueStat.Team.Player?
        let playerB: LeagueStat.Team.Player?
        
        init(playerA: LeagueStat.Team.Player? = nil, playerB: LeagueStat.Team.Player? = nil) {
            self.playerA = playerA
            self.playerB = playerB
        }
    }
}
