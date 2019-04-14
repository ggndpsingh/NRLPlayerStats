//
//  PlayerDetailsView.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class PlayerDetailsCell: UITableViewCell, NibLoading {
    @IBOutlet private var headshotView: AsyncImageView! {
        didSet { headshotView.isRound = true }
    }
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    
    var viewState: ViewState = .init() {
        didSet {
            nameLabel.text = viewState.name
            positionLabel.text = viewState.position
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let id = viewState.playerId else {
            headshotView.image = nil
            return
        }
        
        headshotView.url = StatsAPI.getMediaUrl(playerId: id)
    }
}

extension PlayerDetailsCell {
    struct ViewState {
        let playerId: Int?
        let name: String?
        let position: String?
        
        init(player: LeaguePlayer? = nil) {
            playerId = player?.id
            name = player?.name
            position = player?.position
        }
    }
}
