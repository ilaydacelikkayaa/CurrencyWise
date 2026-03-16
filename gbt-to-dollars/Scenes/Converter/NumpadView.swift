//
//  NumpadView.swift
//  gbt-to-dollars
//
//  Created by İlayda Çelikkaya on 3.03.2026.
//

import UIKit
import SnapKit

final class NumpadView: UIView {

    // MARK: - Callback

    var onKeyTap: ((String) -> Void)?

    // MARK: - UI Elements

    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = AppConstants.Layout.numpadSpacing
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        createButtons()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
    }
    

    private func createButtons() {

        let rows: [[String]] = [
            ["1","2","3"],
            ["4","5","6"],
            ["7","8","9"],
            [".","0","C"]
        ]

        for row in rows {

            let horizontal = UIStackView()
            horizontal.axis = .horizontal
            horizontal.spacing = AppConstants.Layout.numpadSpacing
            horizontal.distribution = .fillEqually
            horizontal.alignment = .center
            for value in row {
                let button = createButton(title: value)
                horizontal.addArrangedSubview(button)
            }

            mainStack.addArrangedSubview(horizontal)
        }
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = title == "C" ? .systemRed : AppColors.cardBackground
    
        button.snp.makeConstraints { make in
            make.size.equalTo(AppConstants.Layout.numpadButtonSize)
        }

        button.layer.cornerRadius = AppConstants.Layout.numpadButtonCornerRadius
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let value = sender.currentTitle else { return }
        onKeyTap?(value)
    }
}
