//
//  MatchStatsPlayerView+ViewState.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

extension MatchStatsPlayerView {
    struct ViewState {
        let statType: LeagueStat.StatType
        let playerId: Int?
        let name: String?
        let position: String?
        let statValue: String?
        
        init(statType: LeagueStat.StatType = .tackles, player: LeagueStat.Team.Player? = nil) {
            self.statType = statType
            playerId = player?.id
            name = player?.shortName
            position = String(optionalInt: player?.jumperNumber) + ". " + (player?.position ?? "")
            statValue = String(optionalInt: player?.statValue) + statType.statValuePostfix
        }
    }
}
