//
//  MatchStatsViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit
import ColorPalette

class MatchStatsViewController: StatsViewController<[LeagueStat]> {
    var match: MatchSelectionViewController.Match = .init() {
        didSet {
            let endpoint: StatsEndpoint = .match(match.year, match.round, match.game)
            statsLoader = .init(endpoint: endpoint)
        }
    }
    
    var viewState: ViewState = .init() {
        didSet {
            title = viewState.title
            tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        title = LocalizedStrings.MatchStats.title
        registerCells(MatchStatsPlayerCell.self)
        registerForPreviewing(with: self, sourceView: tableView)
    }
    
    override func didFinishLoading(stat: [LeagueStat]) {
        viewState = .init(stats: stat)
    }
    
    override func showFailureAlert() {
        let message = LocalizedStrings.MatchStats.failureErrorMessage + " 😞"
        showFailureAlert(message: message) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func createPlayerStatsViewController(teamId: Int, playerId: Int) -> UIViewController {
        let playerStatsViewController = PlayerStatsViewController()
        playerStatsViewController.details = (teamId, playerId)
        return playerStatsViewController
    }
    
    private func presentPlayerStats(teamId: Int, playerId: Int) {
        let viewController = createPlayerStatsViewController(teamId: teamId, playerId: playerId)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

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
            statCell.viewState = viewState.cellViewState(at: indexPath)
            statCell.delegate = self
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MatchStatsViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewState.headerHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewState.titleForSection(at: section)
    }
}

// MARK: - MatchStatsPlayerCellDelegate

extension MatchStatsViewController: MatchStatsPlayerCellDelegate {
    func matchStatsPlayerCell(_ cell: MatchStatsPlayerCell, didTapOnHeadshot playerId: Int, teamId: Int) {
        presentPlayerStats(teamId: teamId, playerId: playerId)
    }
}

// MARK: - UIViewControllerPreviewingDelegate

extension MatchStatsViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let (preview, source) = previewViewController(at: location) else { return nil }
        previewingContext.sourceRect = source
        return preview
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: false)
    }
    
    // Its a bit of work getting peek & pop working here but its definitely worth it.
    func previewViewController(at location: CGPoint) -> (UIViewController, CGRect)? {
        guard
            let indexPath = tableView.indexPathForRow(at: location),
            let cell = tableView.cellForRow(at: indexPath)
        else { return nil }
        
        let mid = UIScreen.main.bounds.width / 2
        let isInLeftView = location.x <= mid
        
        let players = viewState.players(at: indexPath)
        let teams = viewState.teamsIds(at: indexPath)
        let team = isInLeftView ? teams.0 : teams.1
        let player = isInLeftView ? players.0 : players.1
        
        guard let teamId = team, let playerId = player?.id else { return nil }
        
        let viewController = createPlayerStatsViewController(teamId: teamId, playerId: playerId)
        var viewFrame = cell.frame
        viewFrame.origin.x = isInLeftView ? 0 : mid
        viewFrame.size.width = mid
        return (viewController, viewFrame)
    }
}
