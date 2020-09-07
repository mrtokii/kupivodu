//
//  HouseListEndpoint.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

struct HouseListEndpoint: Endpoint {
    
    typealias ResponseType = HouseListResponse
    
    let method: HTTPMethod = .get
    let path: String = "UniversalMobileService/classifiers/downloadClassifiers"
    
    let task: HTTPTask
    let headers: HTTPHeaders? = nil
    
    init() {
        
        let query: Parameters = [
            "classifiersId": "4"
        ]

        task = .request(body: query)
    }
}
