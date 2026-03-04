//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import UIKit

final class ConverterViewModel {

    // MARK: - Properties

    private var inputText: String = ""
    private var isReversed: Bool = false

    private let exchangeRate = AppConstants.Currency.defaultRate
    
    // MARK: - Output

    var currentValues: (input: String, output: String) {
        let inputValue = Double(inputText) ?? 0

        let result: Double

        if isReversed {
            result = inputValue / exchangeRate
        } else {
            result = inputValue * exchangeRate
        }

        let formattedResult = format(result)

        return (inputText, formattedResult)
    }
    
    var currentDisplayState: (topTitle: String, topFlag: String, topAmount: String,
                                  bottomTitle: String, bottomFlag: String, bottomAmount: String) {
            
            let inputValue = Double(inputText) ?? 0
            let convertedValue = isReversed ? (inputValue / exchangeRate) : (inputValue * exchangeRate)
            let formattedOutput = format(convertedValue)
            let displayInput = inputText.isEmpty ? "0" : inputText

            if isReversed {
                return ("USD", "usd_flag", displayInput, "GBP", "gbp_flag", formattedOutput)
            } else {
                return ("GBP", "gbp_flag", displayInput, "USD", "usd_flag", formattedOutput)
            }
        }
    

    private func format(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4
        formatter.numberStyle = .decimal

        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
    
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
