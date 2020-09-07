//
//  NetworkServiceConfiguration.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

struct NetworkServiceConfiguration {

    let baseUrl: URL
    let timeoutInterval: TimeInterval
    let parameterEncoder: ParameterEncoder
    let responseDecoder: ResponseDecoder
    let sessionConfiguration: URLSessionConfiguration

    init(baseUrl: URL,
         parameterEncoder: ParameterEncoder,
         responseDecoder: ResponseDecoder,
         timeoutInterval: TimeInterval) {

        self.baseUrl = baseUrl
        self.parameterEncoder = parameterEncoder
        self.responseDecoder = responseDecoder
        self.timeoutInterval = timeoutInterval

        sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = timeoutInterval
    }
}
