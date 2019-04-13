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
        setupRefreshControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
    }
    
    private func registerCells() {
        tableView.registerCell(PlayerDetailsViewCell.self)
        tableView.registerCell(PlayerDetailsStatCell.self)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadStats), for: .valueChanged)
    }
    
    @objc
    private func loadStats() {
        statsLoader?.request { [weak self] result in
            self?.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let player):
                self?.player = player
            case .failure:
                self?.showFailureAlert()
            }
        }
    }
    
    private func showFailureAlert() {
        let alert = UIAlertController(title: "Error", message: "Failed to load player stats 😞", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerDetailsStatCell.reuseIdentifier, for: indexPath)
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
