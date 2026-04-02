//
//  Double+Formatting.swift
//  gbt-to-dollars
//
//  Created by Ahmet Çağatay Günaydın on 16.03.2026.
//

import Foundation

extension Double {
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func toCurrencyString() -> String {
        Double.currencyFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
