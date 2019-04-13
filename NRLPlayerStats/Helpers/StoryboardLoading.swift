//
//  StoryboardLoading.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 12/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardLoading {}
extension StoryboardLoading {
    static func render(storyboard name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let identifier = String(describing: self)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController as! Self
    }
}
