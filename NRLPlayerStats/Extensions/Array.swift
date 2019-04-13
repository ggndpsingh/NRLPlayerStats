//
//  Array.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        guard count > index else { return nil }
        return self[index]
    }
}
