//
//  UILabel+Factory.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func create(color: UIColor = .black, font: UIFont = .normal(size: 16)) -> UILabel {
        
        let label = UILabel()
        
        label.textColor = color
        label.font = font
        
        return label
    }
}
