//
//  StringExtension.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

public extension String {
    func toDate(
        format: String = "yyyy-MM-dd"
    ) -> Date? {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        formatter.timeZone = .init(abbreviation: "UTC")
        return formatter.date(from: self)
    }
}
