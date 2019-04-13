//
//  MatchStatsPlayerView.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class MatchStatsPlayerView: XibView {
    @IBOutlet private var imageView: AsyncImageView! {
        didSet { imageView.isRound = true }
    }
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    @IBOutlet private var statValueLabel: UILabel!
    
    var viewState: ViewState = .init() {
        didSet {
            nameLabel.text = viewState.name
            positionLabel.text = viewState.position
            statValueLabel.text = viewState.statValue
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let id = viewState.playerId else {
            imageView.image = nil
            return
        }
        
        imageView.url = StatsAPI.getMediaUrl(playerId: id)
    }
    
    func prepareForReuse() {
        viewState = .init()
        imageView.prepareForReuse()
    }
}
