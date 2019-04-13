//
//  MatchSelectionViewController.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class MatchSelectionViewController: UIViewController {
    private var contentView: MatchSelectionContentView {
        guard let view = self.view as? MatchSelectionContentView else {
            fatalError("The content view must be of type MatchSelectionContentView")
        }
        return view
    }
    
    override func loadView() {
        super.loadView()
        title = "🏉 NRL 2017 Stats"
        contentView.delegate = self
    }
}

extension MatchSelectionViewController: MatchSelectionContentViewDelegate {
    func matchSelectionContentView(_ contentView: MatchSelectionContentView, didSelectMatch match: MatchSelectionViewController.Match) {
        let viewController = MatchStatsViewController.render()
        viewController.match = match
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MatchSelectionViewController {
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
