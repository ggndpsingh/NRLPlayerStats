//
//  MatchStatsPlayerView.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

protocol MatchStatsPlayerViewDelegate: class {
    func matchStatsPlayerView(_ view: MatchStatsPlayerView, didTapOnHeadshot playerId: Int)
}

class MatchStatsPlayerView: XibView {
    @IBOutlet private var imageView: AsyncImageView! {
        didSet { imageView.isRound = true }
    }
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    @IBOutlet private var statValueLabel: UILabel!
    @IBOutlet private var imageButton: UIButton!
    
    weak var delegate: MatchStatsPlayerViewDelegate?
    
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
    
    @IBAction private func didTapImage() {
        guard let id = viewState.playerId else { return }
        delegate?.matchStatsPlayerView(self, didTapOnHeadshot: id)
    }
    
    func prepareForReuse() {
        viewState = .init()
        imageView.prepareForReuse()
    }
}
