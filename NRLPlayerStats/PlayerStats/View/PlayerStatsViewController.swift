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
    
    private var statsLoader: StatsLoader<LeaguePlayer>?
    private var player: LeaguePlayer? {
        didSet {
            title = player?.name
            setupHeader()
        }
    }
    
    override func loadView() {
        super.loadView()
        registerCells()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Player Stats"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        statsLoader?.request { [weak self] result in
            switch result {
            case .success(let player):
                self?.player = player
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func registerCells() {
        tableView.registerCell(MatchStatsPlayerCell.self)
    }
    
    private func setupHeader() {
        let detailsView = PlayerDetailsView.render()
        detailsView?.viewState = .init(player: player)
        tableView.tableHeaderView = detailsView
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}

extension PlayerStatsViewController {
    struct Player {
        let teamId: Int
        let playerId: Int
    }
}
