//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import Foundation

final class ConverterViewModel {

    // MARK: - Properties

    private var inputText: String = ""
    private var isReversed: Bool = false
    private let exchangeRate = AppConstants.Currency.defaultRate

    // MARK: - Output

    var displayState: DisplayState {
        let inputValue = Double(inputText) ?? 0
        let convertedValue = isReversed ? (inputValue / exchangeRate) : (inputValue * exchangeRate)
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
}
