//
//  LoadingView.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit
import SnapKit

final class LoadingView: UIView {
    
    private let loadingIndicator = UIActivityIndicatorView(style: .gray)
    private let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        addSubview(loadingIndicator)
        
        container.snp.makeConstraints { make in
            make.size.equalTo(64)
            make.center.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        container.layer.cornerRadius = 12
        container.backgroundColor = .lightGray
        container.alpha = 0.75
        
        loadingIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
