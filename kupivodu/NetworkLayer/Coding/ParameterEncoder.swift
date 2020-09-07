//
//  ParameterEncoder.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with body: Parameters) throws
}
