//
//  UIFont+Extensions.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func normal(size: CGFloat) -> UIFont {
        .systemFont(ofSize: size)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        .boldSystemFont(ofSize: size)
    }
}
