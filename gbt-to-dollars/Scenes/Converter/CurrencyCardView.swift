//
//  CurrencyCardView.swift
//  gbt-to-dollars
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import UIKit
import SnapKit

final class CurrencyCardView: UIView {
    
    // MARK: - Role
    
    enum CardRole { case input, output }
    
    private let role: CardRole
    
    // MARK: - UI Elements
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()
    
    private let labelStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        return stack
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = AppColors.textPrimary
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = AppColors.textTertiary
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    // MARK: - Init
    
    init(title: String, flagName: String, role: CardRole = .output) {
        self.role = role
        super.init(frame: .zero)
        
        backgroundColor = AppColors.cardBackground
        layer.cornerRadius = AppConstants.Layout.cardCornerRadius
        
        if role == .input {
            amountLabel.font = .monospacedDigitSystemFont(ofSize: 34, weight: .bold)
            amountLabel.textColor = AppColors.textPrimary
            layer.borderWidth = 1
            layer.borderColor = UIColor.white.withAlphaComponent(0.07).cgColor
        } else {
            amountLabel.font = .monospacedDigitSystemFont(ofSize: 28, weight: .regular)
            amountLabel.textColor = AppColors.textSecondary
        }
        
        titleLabel.text = title
        countryLabel.text = Self.countryName(for: title)
        flagImageView.image = UIImage(named: flagName)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        addSubview(contentStack)
        
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(countryLabel)
        
        leftStack.addArrangedSubview(flagImageView)
        leftStack.addArrangedSubview(labelStack)
        
        contentStack.addArrangedSubview(leftStack)
        contentStack.addArrangedSubview(amountLabel)
        
        flagImageView.layer.cornerRadius = AppConstants.Layout.flagCornerRadius
    }
    
    private func setupConstraints() {
        contentStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(AppConstants.Layout.cardPadding)
        }
        
        flagImageView.snp.makeConstraints { make in
            make.size.equalTo(AppConstants.Layout.flagSize)
        }
    }
    
    // MARK: - Public Methods
    
    func update(_ state: CurrencyDisplayState) {
        titleLabel.text = state.title
        countryLabel.text = Self.countryName(for: state.title)
        flagImageView.image = UIImage(named: state.flagName)
        amountLabel.text = state.amount
    }
    
    // MARK: - Helpers
    
    private static func countryName(for code: String) -> String {
        switch code {
        case "GBP": return "British Pound"
        case "USD": return "US Dollar"
        case "EUR": return "Euro"
        case "TRY": return "Turkish Lira"
        default:    return ""
        }
    }
}
