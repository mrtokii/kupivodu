//
//  UIStackView+Extensions.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        
        subviews.forEach {
            addArrangedSubview($0)
        }
    }
    
    func addArrangedSubviews(_ subviews: UIView...) {
        
        subviews.forEach {
            addArrangedSubview($0)
        }
    }
}
