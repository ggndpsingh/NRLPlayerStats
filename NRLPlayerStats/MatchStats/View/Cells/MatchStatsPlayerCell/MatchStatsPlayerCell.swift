//
//  MatchStatsPlayerCell.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

protocol MatchStatsPlayerCellDelegate: class {
    func matchStatsPlayerCell(_ cell: MatchStatsPlayerCell, didTapOnHeadshot playerId: Int, teamId: Int)
}

class MatchStatsPlayerCell: UITableViewCell, NibLoading {
    @IBOutlet private var leftPlayerView: MatchStatsPlayerView! {
        didSet {
            leftPlayerView.delegate = self
        }
    }
    
    @IBOutlet private var rightPlayerView: MatchStatsPlayerView! {
        didSet {
            rightPlayerView.delegate = self
        }
    }
    
    weak var delegate: MatchStatsPlayerCellDelegate?
    
    var viewState: ViewState = .init() {
        didSet {
            leftPlayerView.viewState  = .init(statType: viewState.statType, player: viewState.playerA)
            rightPlayerView.viewState = .init(statType: viewState.statType, player: viewState.playerB)
        }
    }
}

extension MatchStatsPlayerCell: MatchStatsPlayerViewDelegate {
    func matchStatsPlayerView(_ view: MatchStatsPlayerView, didTapOnHeadshot playerId: Int) {
        let teamId: Int? = {
            if playerId == viewState.playerA?.id {
                return viewState.teamA
            } else if playerId == viewState.playerB?.id {
                return viewState.teamB
            }
            
            return nil
        }()
        
        guard let id = teamId else { return }
        delegate?.matchStatsPlayerCell(self, didTapOnHeadshot: playerId, teamId: id)
    }
}
