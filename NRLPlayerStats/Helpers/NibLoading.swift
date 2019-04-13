//
//  NibLoading.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoading: class {}
extension NibLoading {
    static var name: String {
        return String(describing: self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: name, bundle: nil)
    }
    
    static func render() -> Self? {
        return Bundle.main.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?.first as? Self
    }
}

