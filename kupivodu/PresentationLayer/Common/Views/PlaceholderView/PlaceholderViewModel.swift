//
//  PlaceholderViewModel.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

struct PlaceholderViewModel {
    
    enum Kind {
        
        case error
    }
    
    // MARK: - Public Properties
    
    let kind: Kind
    let text: String
    
    // MARK: - Public Inits
    
    init(kind: Kind, text: String) {
        self.kind = kind
        self.text = text
    }
    
    init(error: String) {
        self.init(kind: .error, text: error)
    }
}
