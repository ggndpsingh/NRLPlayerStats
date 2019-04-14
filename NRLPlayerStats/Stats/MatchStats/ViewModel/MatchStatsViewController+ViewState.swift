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
        
        var title: String? {
            guard
                let teamA = leagueStats.first?.teamA.name,
                let teamB = leagueStats.first?.teamB.name
            else { return nil }
            return teamA + " - " + teamB
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
        
        func players(at indexPath: IndexPath) -> (LeagueStat.Team.Player?, LeagueStat.Team.Player?) {
            guard let stat = leagueStats.element(at: indexPath.section) else { return (nil, nil) }
            let playerA = stat.teamA.topPlayers.element(at: indexPath.row)
            let playerB = stat.teamB.topPlayers.element(at: indexPath.row)
            return (playerA, playerB)
        }
        
        func teamsIds(at indexPath: IndexPath) -> (Int?, Int?) {
            guard let stat = leagueStats.element(at: indexPath.section) else { return (nil, nil) }
            return (stat.teamA.id, stat.teamB.id)
        }
        
        func statType(at indexPath: IndexPath) -> LeagueStat.StatType {
            return leagueStats.element(at: indexPath.section)?.type ?? .tackles
        }
        
        func cellViewState(at indexPath: IndexPath) -> MatchStatsPlayerCell.ViewState {
            let statType = self.statType(at: indexPath)
            let teamsIds = self.teamsIds(at: indexPath)
            let players  = self.players(at: indexPath)
            return .init(statType: statType, teams: teamsIds, players: players)
        }
    }
}
