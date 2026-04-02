//
//  ExchangeRateRepository.swift
//  gbt-to-dollars
//
//  Created by Ahmet Çağatay Günaydın on 26.03.2026.
//


import Foundation

final class CurrencyRepository {

    static let shared = CurrencyRepository()
    private init() {}

    private let defaults = UserDefaults.standard

    private enum Keys {
        static let cachedRate = "cached_gbp_usd_rate"
        static let cachedDate = "cached_rate_date"
    }

    // MARK: - Persist

    func save(rate: Double, date: String) {
        defaults.set(rate, forKey: Keys.cachedRate)
        defaults.set(date, forKey: Keys.cachedDate)
    }

    // MARK: - Read

    /// Cache'deki rate. Yoksa fallback olarak default rate döner.
    var cachedRate: Double {
        let stored = defaults.double(forKey: Keys.cachedRate)
        return stored > 0 ? stored : AppConstants.Currency.defaultRate
    }

    /// Cache'deki tarih. Yoksa nil.
    var cachedDate: String? {
        defaults.string(forKey: Keys.cachedDate)
    }

    var hasCachedData: Bool {
        defaults.double(forKey: Keys.cachedRate) > 0
    }
}
