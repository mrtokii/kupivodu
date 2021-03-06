//
//  ResponseDecoder.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

protocol ResponseDecoder {
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}
