//
//  Decodable.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 12/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

extension Decodable {
    static var decoder: JSONDecoder {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-ddd"
            formatter.locale = Locale.current
            return formatter
        }()
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

    /// A simple extension to Decodable that allow it to decode itself,
    /// with a custom decoder.
    /// - Parameters:
    ///     - data: Data for the object to be decoded.
    static func decode(from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
