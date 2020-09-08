//
//  HouseInfoCell.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit
import SnapKit

final class HouseInfoCell: UITableViewCell {
    
    private let stackView = UIStackView()
    
    private let cityLabel: UILabel = .create(font: .bold(size: 22))
    private let streetLabel: UILabel = .create(font: .normal(size: 18))
    private let addressLabel: UILabel = .create()
    private let periodLabel: UILabel = .create()
    
    // MARK: - Public Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configure(with model: HouseInfo) {
        
        cityLabel.text = model.city.withoutWhitespace
        streetLabel.text = model.address.withoutWhitespace
        addressLabel.text = model.buildingAddress
        periodLabel.text = model.formattedPeriod ?? model.period
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        
        let labels = [
            cityLabel,
            streetLabel,
            addressLabel,
            periodLabel
        ]
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(labels)
        
        labels.forEach {
            $0.numberOfLines = 0
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.defaultInset)
        }
        
        stackView.axis = .vertical
        stackView.alignment = .fill
    }
}
