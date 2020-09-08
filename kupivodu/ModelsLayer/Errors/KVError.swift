//
//  KVError.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

enum KVError: Error {
    
    case archiveDecode
}

// MARK: - Description

extension KVError {
    
    var localizedDescription: String {
        
        switch self {
        case .archiveDecode:
            return .globalErrorDescriptionUnarchive
        }
    }
}
