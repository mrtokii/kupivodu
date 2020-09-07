//
//  HouseInfo+Extensions.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

extension HouseInfo {
    
    var buildingAddress: String {

        let buildingNumber = building.formattedIfNotEmpty(with: .houseInfoBuilding)
        let buildingPart = part.formattedIfNotEmpty(with: .houseInfoPart)
        let buildingLetter = letter.formattedIfNotEmpty(with: .houseInfoLetter)
        
        return [
            buildingNumber, buildingPart, buildingLetter
        ].compactMap {
            $0
        }.joined(separator: .space)
    }
}

// MARK: - Helpers

private extension String {
    
    func formattedIfNotEmpty(with format: String) -> String? {
        
        withoutWhitespace.isEmpty
            ? nil
            : String(format: format, self)
    }
}
