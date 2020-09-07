//
//  HouseInfo.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

final class HouseInfo: Codable {
    
    enum CodingKeys: String, CodingKey {
        case city = "Населенный пункт"
        case address = "Адрес жилого здания"
        case building = "№ дома"
        case part = "корпус"
        case letter = "литер"
        case period = "Период отключения ГВС"
    }
    
    let city: String
    let address: String
    let building: String
    let part: String
    let letter: String
    let period: String
    
    init(city: String, address: String, building: String, part: String, letter: String, period: String) {
        self.city = city
        self.address = address
        self.building = building
        self.part = part
        self.letter = letter
        self.period = period
    }
}

// MARK: - Equatable

extension HouseInfo: Equatable {
    
    static func == (lhs: HouseInfo, rhs: HouseInfo) -> Bool {
        lhs.city == rhs.city &&
        lhs.address == rhs.address &&
        lhs.building == rhs.building &&
        lhs.part == rhs.part &&
        lhs.letter == rhs.letter &&
        lhs.period == rhs.period
    }
}
