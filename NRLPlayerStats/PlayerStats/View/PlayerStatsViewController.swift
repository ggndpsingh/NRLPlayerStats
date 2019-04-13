//
//  PlayerStatsViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class PlayerStatsViewController: UITableViewController, StoryboardLoading {
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
            setupHeader()
            tableView.reloadData()
        }
    }
    
    private var statsLoader: StatsLoader<LeaguePlayer>?
    
    private var viewState: ViewState = .init() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Player Stats"
        navigationController?.navigationBar.prefersLargeTitles = true
        loadStats()
    }
    
    private func setupHeader() {
        let detailsView = PlayerDetailsView.render()
        detailsView?.viewState = .init(player: player)
        tableView.tableHeaderView = detailsView
        view.setNeedsLayout()
        view.layoutIfNeeded()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath)
        cell.textLabel?.text = viewState.title(at: indexPath)
        cell.detailTextLabel?.text = viewState.value(at: indexPath)
        return cell
    }
}

extension PlayerStatsViewController {
    struct Player {
        let teamId: Int
        let playerId: Int
    }
}
