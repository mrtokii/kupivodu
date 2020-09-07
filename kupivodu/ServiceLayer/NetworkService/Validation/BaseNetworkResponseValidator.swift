//
//  BaseNetworkResponseValidator.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

class BaseNetworkResponseValidator: NetworkResponseValidator {
    
    var acceptableStatusCodes: Range<Int> {
        return 200..<300
    }
    
    func validate(_ response: URLResponse) throws {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.network
        }
        
        guard acceptableStatusCodes.contains(httpResponse.statusCode) else {
            throw NetworkError.response(httpResponse)
        }
    }
}
