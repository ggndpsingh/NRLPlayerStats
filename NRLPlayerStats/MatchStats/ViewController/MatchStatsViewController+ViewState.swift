//
//  MatchStatsViewController+ViewState.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

extension MatchStatsViewController {
    struct ViewState {
        private let leagueStats: [LeagueStat]
        
        let headerHeight: CGFloat = 44
        
        init(stats: [LeagueStat] = []) {
            leagueStats = stats
        }
        
        var numberOfSections: Int {
            return leagueStats.count
        }
        
        func numberOfRows(in section: Int) -> Int {
            guard let stats = leagueStats.element(at: section) else { return 0 }
            return max(stats.teamA.topPlayers.count, stats.teamB.topPlayers.count)
        }
        
        func titleForSection(at index: Int) -> String? {
            guard let stat = leagueStats.element(at: index) else { return nil }
            return stat.type.title
        }
    }
}
