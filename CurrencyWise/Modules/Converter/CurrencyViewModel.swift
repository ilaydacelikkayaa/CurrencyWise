//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import Foundation

final class CurrencyViewModel {

    // MARK: - Properties

    private var inputText: String = ""
    private var isReversed: Bool = false
    private var exchangeRate: Double = CurrencyRepository.shared.cachedRate
    private var rateDate: String? = CurrencyRepository.shared.cachedDate
    private(set) var isLoadingRate: Bool = false
    private(set) var isOffline: Bool = false

    // MARK: - Callbacks

    var onRateUpdated: (() -> Void)?
    var onRateError: ((String) -> Void)?

    // MARK: - Output

    var displayState: DisplayState {
        let inputValue = Double(inputText) ?? 0
        let convertedValue = isReversed
            ? (inputValue / exchangeRate)
            : (inputValue * exchangeRate)

        let displayInput = inputText.isEmpty ? "0" : inputText
        let formattedOutput = convertedValue.toCurrencyString()

        if isReversed {
            return DisplayState(
                top: CurrencyDisplayState(title: "USD", flagName: "usd_flag", amount: displayInput),
                bottom: CurrencyDisplayState(title: "GBP", flagName: "gbp_flag", amount: formattedOutput)
            )
        } else {
            return DisplayState(
                top: CurrencyDisplayState(title: "GBP", flagName: "gbp_flag", amount: displayInput),
                bottom: CurrencyDisplayState(title: "USD", flagName: "usd_flag", amount: formattedOutput)
            )
        }
    }

    /// "Last updated 2026-03-25 · Live rate" veya "Last updated 2026-03-24 · Offline" gibi
    var lastUpdatedText: String {
        if isLoadingRate {
            return "Fetching latest rates..."
        }

        let dateString: String
        if let raw = rateDate {
            dateString = formatDate(raw)
        } else {
            dateString = "Unknown"
        }

        if isOffline {
            return "Last updated \(dateString) · Offline"
        } else {
            return "Last updated \(dateString)"
        }
    }

    // MARK: - Network

    func fetchLatestRate() {
        isLoadingRate = true
        isOffline = false

        Task { [weak self] in
            guard let self else { return }

            do {
                let result = try await ExchangeRateService.shared.fetchGBPtoUSD()
                CurrencyRepository.shared.save(rate: result.rate, date: result.date)

                await MainActor.run {
                    self.exchangeRate = result.rate
                    self.rateDate = result.date
                    self.isLoadingRate = false
                    self.isOffline = false
                    self.onRateUpdated?()
                }
            } catch ExchangeRateError.noInternet {
                await MainActor.run {
                    self.isLoadingRate = false
                    self.isOffline = true
                    // Cached rate zaten mevcut, kullanmaya devam et
                    self.onRateUpdated?()
                }
            } catch {
                await MainActor.run {
                    self.isLoadingRate = false
                    self.isOffline = !CurrencyRepository.shared.hasCachedData
                    self.onRateError?("Couldn't fetch rates. Using cached data.")
                    self.onRateUpdated?()
                }
            }
        }
    }

    // MARK: - Input

    func didTapNumber(_ number: String) {
        if inputText == "0" && number == "0" { return }
        if inputText == "0" && number != "0" {
            inputText = number
            return
        }
        inputText += number
    }

    func didTapDot() {
        if inputText.isEmpty {
            inputText = "0."
            return
        }
        if !inputText.contains(".") {
            inputText += "."
        }
    }

    func didTapClear() {
        inputText = ""
    }

    func didTapSwap() {
        isReversed.toggle()
    }

    // MARK: - Helpers

    private func formatDate(_ raw: String) -> String {
        // Frankfurter "2026-03-25" formatında döner
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: raw) else { return raw }

        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}
