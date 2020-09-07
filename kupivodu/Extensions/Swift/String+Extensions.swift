//
//  String+Extensions.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

extension String {
    
    var withoutWhitespace: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Constants

extension String {
    
    static let empty = ""
    static let space = " "
}
