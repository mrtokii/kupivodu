//
//  JSONParameterEncoder.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
        
    func encode(urlRequest: inout URLRequest, with body: Parameters) throws {
        
        do {
            
            let jsonAsData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
        } catch {
            throw NetworkError.encoding
        }
    }
}
