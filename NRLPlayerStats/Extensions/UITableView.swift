//
//  UITableView.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(_ cell: NibLoading.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.name)
    }
}
