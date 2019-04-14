//
//  StatsViewControllerProtocol.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 14/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

class StatsViewController<T: Decodable>: UITableViewController {
    var statsLoader: StatsLoader<T>?
    
    override func loadView() {
        super.loadView()
        setupRefreshControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStats()
    }
    
    func registerCells(_ cells: NibLoading.Type...) {
        cells.forEach { tableView.registerCell($0) }
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadStats), for: .valueChanged)
    }
    
    // MARK: - Load Stats
    
    @objc
    func loadStats() {
        statsLoader?.request { [weak self] result in
            self?.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let stat):
                self?.didFinishLoading(stat: stat)
            default:
                self?.showFailureAlert()
            }
        }
    }
    
    // MARK: - Handle Load Completion
    
    // There has to be a better way of doing this, but with Generic Types,
    // things don't work like you would think they do, yet.
    
    /// Subclasses must override this methods to handle completion
    func didFinishLoading(stat: T) {}
    
    /// Subclasses must override this methods to handle failure
    func showFailureAlert() {}
    
    // MARK: - Show Failure Alert
    
    func showFailureAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
