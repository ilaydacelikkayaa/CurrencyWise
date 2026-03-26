//
//  WelcomeViewController.swift
//  gbt-to-dollars
//
//  Created by Ahmet Çağatay Günaydın on 26.03.2026.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency\nConverter"
        label.font = .systemFont(ofSize: 44, weight: .bold)
        label.textColor = AppColors.textPrimary
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "GBP · USD"
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0.4, green: 0.65, blue: 1.0, alpha: 1)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let featureStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(AppColors.textPrimary, for: .normal)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let divider: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white.withAlphaComponent(0.06)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private var buttonGradientLayer: CAGradientLayer?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        addBackgroundGradient()
        setupUI()
        setupConstraints()
        setupFeatures()
        setupActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if buttonGradientLayer == nil {
            let gradient = CAGradientLayer()
            gradient.colors = [
                UIColor(red: 0.25, green: 0.5, blue: 1.0, alpha: 1).cgColor,
                UIColor(red: 0.15, green: 0.35, blue: 0.9, alpha: 1).cgColor
            ]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.cornerRadius = 16
            continueButton.layer.insertSublayer(gradient, at: 0)
            buttonGradientLayer = gradient
        }
        
        buttonGradientLayer?.frame = continueButton.bounds
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(divider)
        view.addSubview(featureStack)
        view.addSubview(continueButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.Layout.horizontalPadding),
            
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.Layout.horizontalPadding),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            featureStack.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 32),
            featureStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            featureStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.Layout.horizontalPadding),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AppConstants.Layout.horizontalPadding),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AppConstants.Layout.horizontalPadding),
            continueButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setupFeatures() {
        let items: [(String, String, String)] = [
            ("arrow.left.arrow.right", "Real-Time Conversion", "Always up-to-date GBP and USD exchange rates"),
            ("wifi", "Offline Support", "Last fetched rate saved locally — works without internet"),
            ("lock.shield", "No Ads, No Tracking", "Clean and private, just the conversion you need")
        ]
        
        for (icon, title, description) in items {
            featureStack.addArrangedSubview(makeFeatureRow(icon: icon, title: title, description: description))
        }
    }
    
    private func makeFeatureRow(icon: String, title: String, description: String) -> UIView {
        let container = UIView()
        container.backgroundColor = AppColors.cardBackground
        container.layer.cornerRadius = AppConstants.Layout.cardCornerRadius
        container.translatesAutoresizingMaskIntoConstraints = false
        
        let accentBar = UIView()
        accentBar.backgroundColor = UIColor(red: 0.3, green: 0.6, blue: 1.0, alpha: 0.7)
        accentBar.layer.cornerRadius = 2
        accentBar.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        iconView.image = UIImage(systemName: icon, withConfiguration: config)
        iconView.tintColor = UIColor(red: 0.4, green: 0.65, blue: 1.0, alpha: 1)
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLbl = UILabel()
        titleLbl.text = title
        titleLbl.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLbl.textColor = AppColors.textPrimary
        
        let descLbl = UILabel()
        descLbl.text = description
        descLbl.font = .systemFont(ofSize: 13, weight: .regular)
        descLbl.textColor = AppColors.textSecondary
        descLbl.numberOfLines = 2
        
        let textStack = UIStackView(arrangedSubviews: [titleLbl, descLbl])
        textStack.axis = .vertical
        textStack.spacing = 3
        textStack.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(accentBar)
        container.addSubview(iconView)
        container.addSubview(textStack)
        
        NSLayoutConstraint.activate([
            accentBar.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            accentBar.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            accentBar.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12),
            accentBar.widthAnchor.constraint(equalToConstant: 3),
            
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            textStack.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            textStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            textStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            textStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        return container
    }
    
    private func addBackgroundGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(red: 0.08, green: 0.10, blue: 0.18, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        gradient.locations = [0.0, 0.6]
        gradient.startPoint = CGPoint(x: 0.3, y: 0)
        gradient.endPoint = CGPoint(x: 0.7, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupActions() {
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)
        continueButton.addTarget(self, action: #selector(buttonUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    // MARK: - Actions
    
    @objc private func continueTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        UserDefaults.standard.set(true, forKey: "onboarding_completed")
        dismiss(animated: true)
    }
    
    @objc private func buttonDown() {
        UIView.animate(withDuration: 0.1) {
            self.continueButton.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.continueButton.alpha = 0.8
        }
    }
    
    @objc private func buttonUp() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6) {
            self.continueButton.transform = .identity
            self.continueButton.alpha = 1
        }
    }
}
