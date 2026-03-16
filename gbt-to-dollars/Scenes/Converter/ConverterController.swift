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
        label.text = "Last updated 04/03 5:12am\nUnlock premium for live exchange rates"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let topContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = AppConstants.Layout.defaultSpacing
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let currencyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = AppConstants.Layout.defaultSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let gbpCard = CurrencyCardView(
        title: "GBP",
        flagName: "gbp_flag"
    )
    
    private let usdCard = CurrencyCardView(
        title: "USD",
        flagName: "usd_flag"
    )
    
    private let swapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        button.tintColor = AppColors.textPrimary
        button.backgroundColor = AppColors.cardBackground
        button.layer.cornerRadius = AppConstants.Layout.cardCornerRadius
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
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.addSubview(topContainerStack)
        view.addSubview(numpadView)
        view.addSubview(lastUpdatedLabel)
        
        topContainerStack.addArrangedSubview(currencyStack)
        topContainerStack.addArrangedSubview(swapButton)
        
        currencyStack.addArrangedSubview(gbpCard)
        currencyStack.addArrangedSubview(usdCard)
        
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topContainerStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: AppConstants.Layout.topSpacing),
            topContainerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            topContainerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.Layout.horizontalPadding),
            
            currencyStack.widthAnchor.constraint(equalTo: topContainerStack.widthAnchor, multiplier: AppConstants.Layout.currencyStackWidthMultiplier),
            
            gbpCard.heightAnchor.constraint(equalToConstant: AppConstants.Layout.cardHeight),
            usdCard.heightAnchor.constraint(equalToConstant: AppConstants.Layout.cardHeight),
            
            swapButton.widthAnchor.constraint(equalToConstant: AppConstants.Layout.swapButtonWidth),
            swapButton.heightAnchor.constraint(equalTo: currencyStack.heightAnchor),
            
            numpadView.topAnchor.constraint(equalTo: topContainerStack.bottomAnchor, constant: AppConstants.Layout.numpadTopSpacing),
            numpadView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numpadView.widthAnchor.constraint(equalToConstant: AppConstants.Layout.numpadWidth),
            
            lastUpdatedLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: AppConstants.Layout.footerBottomSpacing),
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
    }
    
    // MARK: - Actions
    
    @objc private func swapTapped() {
        viewModel.didTapSwap()
        updateUI()
    }
    
    // MARK: - UI Update
    
    private func updateUI() {
        let state = viewModel.displayState

        gbpCard.update(state.top)
        usdCard.update(state.bottom)
    }
}
