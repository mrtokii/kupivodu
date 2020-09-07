//
//  HTTPTask.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters  = [String: Any]

enum HTTPTask {
    
    case request(body: Parameters?)
}
