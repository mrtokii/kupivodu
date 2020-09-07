//
//  UIView+Extensions.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        
        subviews.forEach {
            addSubview($0)
        }
    }
}
