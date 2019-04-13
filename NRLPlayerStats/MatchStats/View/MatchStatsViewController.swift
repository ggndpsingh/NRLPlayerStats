//
//  MatchStatsViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class MatchStatsViewController: UITableViewController {
    
    var match: MatchSelectionViewController.Match = .init() {
        didSet {
            let endpoint: StatsEndpoint = .match(match.year, match.round, match.game)
            statsLoader = .init(endpoint: endpoint)
        }
    }
    
    private var statsLoader: StatsLoader<[LeagueStat]>?
    
    private var viewState: ViewState = .init() {
        didSet {
            title = viewState.title
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        title = "Match Stats"
        registerCells()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
    }
    
    private func registerCells() {
        tableView.registerCell(MatchStatsPlayerCell.self)
    }
    
    private func loadStats() {
        statsLoader?.request { [weak self] result in
            switch result {
            case .success(let stats):
                self?.viewState = .init(stats: stats)
            default:
                self?.showFailureAlert()
            }
        }
    }
    
    private func showFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "No stats found for this match 😞", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension MatchStatsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewState.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchStatsPlayerCell.reuseIdentifier, for: indexPath)
        if let statCell = cell as? MatchStatsPlayerCell {
            let statType = viewState.statType(at: indexPath)
            let teamsIds = viewState.teamsIds(at: indexPath)
            let players = viewState.players(at: indexPath)
            statCell.viewState = .init(statType: statType, teams: teamsIds, players: players)
            statCell.delegate = self
        }
        
        return cell
    }
}

extension MatchStatsViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewState.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewState.titleForSection(at: section)
    }
}

extension MatchStatsViewController: MatchStatsPlayerCellDelegate {
    func matchStatsPlayerCell(_ cell: MatchStatsPlayerCell, didTapOnHeadshot playerId: Int, teamId: Int) {
        presentPlayerStats(teamId: teamId, playerId: playerId)
    }
    
    private func presentPlayerStats(teamId: Int, playerId: Int) {
        let playervc = PlayerStatsViewController()
        playervc.details = (teamId, playerId)
        navigationController?.pushViewController(playervc, animated: true)
    }
}
