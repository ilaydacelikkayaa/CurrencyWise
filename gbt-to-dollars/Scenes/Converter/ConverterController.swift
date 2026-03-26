//
//  ConverterController.swift
//  CurrencyConverter
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import UIKit

final class ConverterController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = ConverterViewModel()
    
    // MARK: - UI Elements
    
    private let numpadView: NumpadView = {
        let view = NumpadView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Last updated"
        label.textColor = UIColor.white.withAlphaComponent(0.25)
        label.font = .monospacedDigitSystemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let gbpCard = CurrencyCardView(title: "GBP", flagName: "gbp_flag", role: .input)
    private let usdCard = CurrencyCardView(title: "USD", flagName: "usd_flag", role: .output)
    
    private let swapButton: UIButton = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
        button.setImage(UIImage(systemName: "arrow.up.arrow.down", withConfiguration: config), for: .normal)
        button.tintColor = AppColors.textSecondary
        button.backgroundColor = AppColors.background
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        
        setupUI()
        setupBindings()
        updateUI()
        viewModel.fetchLatestRate()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.addSubview(cardContainer)
        view.addSubview(numpadView)
        view.addSubview(lastUpdatedLabel)
        
        cardContainer.addSubview(gbpCard)
        cardContainer.addSubview(usdCard)
        cardContainer.addSubview(swapButton)
        
        gbpCard.translatesAutoresizingMaskIntoConstraints = false
        usdCard.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cardContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            cardContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.Layout.horizontalPadding),
            
            gbpCard.topAnchor.constraint(equalTo: cardContainer.topAnchor),
            gbpCard.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor),
            gbpCard.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor),
            gbpCard.heightAnchor.constraint(equalToConstant: AppConstants.Layout.cardHeight),
            
            usdCard.topAnchor.constraint(equalTo: gbpCard.bottomAnchor, constant: 2),
            usdCard.leadingAnchor.constraint(equalTo: cardContainer.leadingAnchor),
            usdCard.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor),
            usdCard.heightAnchor.constraint(equalToConstant: AppConstants.Layout.cardHeight),
            usdCard.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor),
            
            swapButton.centerYAnchor.constraint(equalTo: usdCard.topAnchor),
            swapButton.trailingAnchor.constraint(equalTo: cardContainer.trailingAnchor, constant: -16),
            swapButton.widthAnchor.constraint(equalToConstant: 32),
            swapButton.heightAnchor.constraint(equalToConstant: 32),
            
            numpadView.topAnchor.constraint(equalTo: cardContainer.bottomAnchor, constant: AppConstants.Layout.numpadTopSpacing),
            numpadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numpadView.widthAnchor.constraint(equalToConstant: AppConstants.Layout.numpadWidth),
            
            lastUpdatedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            lastUpdatedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        numpadView.onKeyTap = { [weak self] value in
            guard let self = self else { return }
            
            switch value {
            case "C":
                self.viewModel.didTapClear()
            case ".":
                self.viewModel.didTapDot()
            default:
                self.viewModel.didTapNumber(value)
            }
            
            self.updateUI()
        }
        
        swapButton.addTarget(self, action: #selector(swapTapped), for: .touchUpInside)
        
        viewModel.onRateUpdated = { [weak self] in
            self?.updateUI()
        }

        viewModel.onRateError = { [weak self] message in
            self?.updateUI()
        }
    }
    
    // MARK: - Actions
    
    @objc private func swapTapped() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 8) {
            self.swapButton.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            self.swapButton.transform = .identity
        }
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        viewModel.didTapSwap()
        updateUI()
    }
    
    // MARK: - UI Update
    
    private func updateUI() {
        let state = viewModel.displayState
        gbpCard.update(state.top)
        usdCard.update(state.bottom)
        lastUpdatedLabel.text = viewModel.lastUpdatedText
    }
}
