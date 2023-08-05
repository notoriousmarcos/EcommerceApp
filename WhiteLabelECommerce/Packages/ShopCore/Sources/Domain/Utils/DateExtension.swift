//
//  DateExtension.swift
//  ShopCore
//
//  Created by Marcos Vinicius Brito on 19/02/22.
//

import Foundation

public extension Date {
    func toString(
        format: String = "yyyy-MM-dd"
    ) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
