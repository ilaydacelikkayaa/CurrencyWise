//
//  CurrencyCardView.swift
//  gbt-to-dollars
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import UIKit

final class CurrencyCardView: UIView {

    // MARK: - UI Elements

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textSecondary
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.textPrimary
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    // MARK: - Init

    init(title: String, flagName: String) {
        super.init(frame: .zero)

        backgroundColor = AppColors.cardBackground
        layer.cornerRadius = AppConstants.Layout.cardCornerRadius

        titleLabel.text = title
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

        
        contentStack.addArrangedSubview(leftStack)
        contentStack.addArrangedSubview(amountLabel)

        leftStack.addArrangedSubview(flagImageView)
        leftStack.addArrangedSubview(titleLabel)
    }

    private func setupConstraints() {
            NSLayoutConstraint.activate([
                contentStack.topAnchor.constraint(equalTo: topAnchor, constant: AppConstants.Layout.cardPadding),
                contentStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -AppConstants.Layout.cardPadding),
                contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AppConstants.Layout.cardPadding),
                contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AppConstants.Layout.cardPadding),

                flagImageView.widthAnchor.constraint(equalToConstant: AppConstants.Layout.flagSize),
                flagImageView.heightAnchor.constraint(equalToConstant: AppConstants.Layout.flagSize)
            ])

            flagImageView.layer.cornerRadius = AppConstants.Layout.flagCornerRadius
        }

    // MARK: - Public Methods

    func updateAmount(_ text: String) {
        amountLabel.text = text
    }
    
    func updateTitle(_ title: String, flagName: String) {
        titleLabel.text = title
        flagImageView.image = UIImage(named: flagName)
    }
}
