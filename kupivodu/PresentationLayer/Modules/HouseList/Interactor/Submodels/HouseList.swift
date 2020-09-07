//
//  HouseList.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

final class HouseList {
    
    let houses: [HouseInfo]
    
    init(houses: [HouseInfo]) {
        self.houses = houses
    }
}

// MARK: - Equatable

extension HouseList: Equatable {
    
    static func == (lhs: HouseList, rhs: HouseList) -> Bool {
        lhs.houses == rhs.houses
    }
}
