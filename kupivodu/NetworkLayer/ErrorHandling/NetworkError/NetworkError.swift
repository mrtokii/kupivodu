//
//  NetworkError.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case encoding
    case network
    case response(HTTPURLResponse?)
}
