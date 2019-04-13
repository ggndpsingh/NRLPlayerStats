//
//  String.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 12/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

extension String {
    var asNSString: NSString {
        return (self as NSString)
    }
    
    func stringByAppendingPathComponent(_ component: String) -> String {
        return asNSString.appendingPathComponent(component)
    }
}

extension String {
    init(int: Int, addLeadingZero: Bool = true) {
        guard addLeadingZero else {
            self = "\(int)"
            return
        }
        self = int < 10 ? "0\(int)" : "\(int)"
    }
    
    init(optionalInt: Int?) {
        guard let int = optionalInt else {
            self = ""
            return
        }
        self = "\(int)"
    }
}
