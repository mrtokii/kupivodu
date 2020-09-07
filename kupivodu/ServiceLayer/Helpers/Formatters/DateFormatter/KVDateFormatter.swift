//
//  KVDateFormatter.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

struct KVDateFormatter {
    
    private let formatter = DateFormatter()
    
    // MARK: - Public Properties
    
    var format: String {
        formatter.dateFormat
    }
    
    // MARK: - Public Init
    
    init(format: String) {
        formatter.dateFormat = format
    }
    
    // MARK: - Public Methods
    
    func string(from date: Date) -> String {
        formatter.string(from: date)
    }
    
    func date(from string: String) -> Date? {
        formatter.date(from: string)
    }
}
