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
    
    var match: Match = .init() {
        didSet {
            let endpoint: StatsEndpoint = .match(match.year, match.round, match.game)
            statsLoader = .init(endpoint: endpoint)
        }
    }
    
    private var statsLoader: StatsLoader<[LeagueStat]>?
    
    private var viewState: ViewState = .init() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        registerCells()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Match Stats"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        match = Match()
        statsLoader?.request { [weak self] result in
            switch result {
            case .success(let stats):
                self?.viewState = .init(stats: stats)
            default:
                break
            }
        }
    }
    
    private func registerCells() {
        tableView.registerCell(MatchStatsPlayerCell.self)
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

extension MatchStatsViewController {
    struct Match {
        let year: Int
        let round: Int
        let game: Int
        
        init(year: Int = 2017, round: Int = 1, match: Int = 1) {
            self.year = year
            self.round = round
            self.game = match
        }
    }
}
