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
        let name: String?
        let position: String?
        let statValue: String?
        
        init(player: LeagueStat.Team.Player? = nil) {
            name = player?.shortName
            position = String(optionalInt: player?.jumperNumber) + ". " + (player?.position ?? "")
            statValue = String(optionalInt: player?.statValue)
        }
    }
}
