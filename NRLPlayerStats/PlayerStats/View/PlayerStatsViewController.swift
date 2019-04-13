//
//  PlayerStatsViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class PlayerStatsViewController: UITableViewController {
    private let statCellIdentifier = "PlayerStatCell"
    
    var details: (Int, Int)? = nil {
        didSet {
            guard let (teamId, playerId) = details else { return }
            let endpoint: StatsEndpoint = .player(teamId, playerId)
            statsLoader = .init(endpoint: endpoint)
        }
    }
    
    private var player: LeaguePlayer? {
        didSet {
            title = player?.name
            self.viewState = .init(player: player)
            tableView.reloadData()
        }
    }
    
    private var statsLoader: StatsLoader<LeaguePlayer>?
    
    private var viewState: ViewState = .init() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        title = "Player Stats"
        registerCells()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
    }
    
    private func registerCells() {
        tableView.registerCell(PlayerDetailsViewCell.self)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: statCellIdentifier)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.tableView.tableHeaderView?.layoutIfNeeded()
    }
    
    private func loadStats() {
        statsLoader?.request { [weak self] result in
            switch result {
            case .success(let player):
                self?.player = player
            case .failure(let error):
                print(error)
            }
        }
    }
}

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
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerDetailsViewCell.reuseIdentifier, for: indexPath)
            if let playerCell = cell as? PlayerDetailsViewCell {
                playerCell.viewState = .init(player: player)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: statCellIdentifier, for: indexPath)
            cell.textLabel?.text = viewState.title(at: indexPath)
            cell.detailTextLabel?.text = viewState.value(at: indexPath)
            return cell
        }
    }
}

extension PlayerStatsViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewState.heightForHeader(in: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewState.titleForHeader(in: section)
    }
}

extension PlayerStatsViewController {
    struct Player {
        let teamId: Int
        let playerId: Int
    }
}
