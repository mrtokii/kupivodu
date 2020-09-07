//
//  NetworkServiceConfiguration+Defaults.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

extension NetworkServiceConfiguration {
    
    static let base: Self = .init(baseUrl: UrlProvider.base,
                                  parameterEncoder: JSONParameterEncoder(),
                                  responseDecoder: JSONDecoder(),
                                  timeoutInterval: 30)
}
