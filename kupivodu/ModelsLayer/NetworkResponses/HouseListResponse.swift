//
//  HouseListResponse.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

final class HouseListResponse: Codable {
    
    let status: String
    let responseData: HouseListResponseData
    let expectedResponseDate: String
}

final class HouseListResponseData: Codable {
    
    let classifiers: [HouseListResponseDataClassifier]
}

final class HouseListResponseDataClassifier: Codable {
    
    let classifierId: Int
    let classifierName: String
    let file: Data
    let version: String
}
