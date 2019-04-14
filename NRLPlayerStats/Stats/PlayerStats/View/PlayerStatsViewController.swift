//
//  PlayerStatsViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class PlayerStatsViewController: StatsViewController<LeaguePlayer> {
    private let statCellIdentifier = "PlayerStatCell"
    
    var details: (Int, Int)? = nil {
        didSet {
            guard let (teamId, playerId) = details else { return }
            let endpoint: StatsEndpoint = .player(teamId, playerId)
            statsLoader = .init(endpoint: endpoint)
        }
    }
    
    private var viewState: ViewState = .init() {
        didSet {
            title = viewState.title
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        title = LocalizedStrings.PlayerStats.title
        registerCells(PlayerDetailsCell.self, PlayerDetailsStatCell.self)
    }
    
    override func didFinishLoading(stat: LeaguePlayer) {
        viewState = .init(player: stat)
    }
    
    override func showFailureAlert() {
        let message = LocalizedStrings.PlayerStats.failureErrorMessage + " 😞"
        showFailureAlert(message: message) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension PlayerStatsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewState.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewState.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerDetailsCell.reuseIdentifier, for: indexPath)
            if let playerCell = cell as? PlayerDetailsCell {
                playerCell.viewState = viewState.playerDetailsViewState
            }
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerDetailsStatCell.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = viewState.title(at: indexPath)
            cell.detailTextLabel?.text = viewState.value(at: indexPath)
            cell.selectionStyle = .none
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension PlayerStatsViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewState.heightForHeader(in: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewState.titleForHeader(in: section)
    }
}
