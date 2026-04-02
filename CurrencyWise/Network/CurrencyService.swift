//
//  ExchangeRateError.swift
//  gbt-to-dollars
//
//  Created by Ahmet Çağatay Günaydın on 26.03.2026.
//


import Foundation

enum ExchangeRateError: Error {
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case noInternet
}

struct FrankfurterResponse: Decodable {
    let date: String
    let rates: [String: Double]
}

final class ExchangeRateService {

    static let shared = ExchangeRateService()
    private init() {}

    private let baseURL = "https://api.frankfurter.app/latest"

    // GBP → USD rate'i çeker. Base: GBP, target: USD
    func fetchGBPtoUSD() async throws -> (rate: Double, date: String) {
        guard let url = URL(string: "\(baseURL)?base=GBP&symbols=USD") else {
            throw ExchangeRateError.invalidResponse
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw ExchangeRateError.invalidResponse
            }

            let decoded = try JSONDecoder().decode(FrankfurterResponse.self, from: data)

            guard let rate = decoded.rates["USD"] else {
                throw ExchangeRateError.invalidResponse
            }

            return (rate, decoded.date)

        } catch let error as ExchangeRateError {
            throw error
        } catch {
            // URLError içinde internet olmadığını yakala
            if (error as? URLError)?.code == .notConnectedToInternet {
                throw ExchangeRateError.noInternet
            }
            throw ExchangeRateError.networkError(error)
        }
    }
}
