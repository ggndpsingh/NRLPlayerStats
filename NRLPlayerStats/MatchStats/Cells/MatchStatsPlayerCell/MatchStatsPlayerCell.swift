//
//  MatchStatsPlayerCell.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class MatchStatsPlayerCell: UITableViewCell, NibLoading {
    @IBOutlet private var leftPlayerView: MatchStatsPlayerView!
    @IBOutlet private var rightPlayerView: MatchStatsPlayerView!
    
    var viewState: ViewState = .init() {
        didSet {
            leftPlayerView.viewState  = .init(statType: viewState.statType, player: viewState.playerA)
            rightPlayerView.viewState = .init(statType: viewState.statType, player: viewState.playerB)
        }
    }
}
