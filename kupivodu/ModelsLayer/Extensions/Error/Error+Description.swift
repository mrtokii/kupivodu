//
//  Error+Description.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

extension Error {
    
    var description: String {
        
        switch self {
        case is NetworkError:
            return .globalErrorDescriptionNetwork
        case let kvError as KVError:
            return kvError.localizedDescription
        default:
            return .globalErrorDescriptionUnknown
        }
    }
}
