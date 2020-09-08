//
//  PlaceholderView.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit
import SnapKit

final class PlaceholderView: UIView {
    
    private let stackView = UIStackView()

    private let descriptionLabel: UILabel = .create(font: .bold(size: 24))
    private let retryButton = UIButton()
    
    // MARK: - Public Properties
    
    var onRetry: (() -> Void)?
    
    // MARK: - Public Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with model: PlaceholderViewModel) {
        
        descriptionLabel.text = model.text
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        
        backgroundColor = .white
        
        addSubviews(stackView)
        stackView.addArrangedSubviews(descriptionLabel, retryButton)
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 48
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(CGFloat.hugeInset)
            make.centerY.equalToSuperview()
        }
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        retryButton.backgroundColor = tintColor
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.layer.cornerRadius = 12
        retryButton.setTitle(.errorPlaceholderTryAgain, for: .normal)
        retryButton.addTarget(self, action: #selector(onRetryTap), for: .touchUpInside)
    }
    
    @objc private func onRetryTap() {
        onRetry?()
    }
}
