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

// MARK: - Date Converter

extension String {
    
    func convert(from source: String, to target: String) -> String? {
        
        let sourceFormatter = KVDateFormatter(format: source)
        let targetFormatter = KVDateFormatter(format: target)
        
        guard let date = sourceFormatter.date(from: self) else {
            return nil
        }
        
        return targetFormatter.string(from: date)
    }
}

// MARK: - Constants

extension String {
    
    static let empty = ""
    static let space = " "
    static let dash = "-"
    
    static let defaultDateFormat = "d MMM yyyy"
}
