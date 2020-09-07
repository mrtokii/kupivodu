//
//  HouseInfo.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

final class HouseInfo: Equatable {
    
    static func == (lhs: HouseInfo, rhs: HouseInfo) -> Bool {
        lhs.address == rhs.address
    }
    
    let address: String
    
    init(address: String) {
        self.address = address
    }
}
