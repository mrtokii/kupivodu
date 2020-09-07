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
    
    var formattedPeriod: String? {
        
        // Source string: "01.01.2020-01.01.2020"
        
        let datesArray = period.split(separator: .init(.dash)).map { String($0) }
        
        guard datesArray.count == 2 else {
            return nil
        }
        
        let startDateString = datesArray[0]
        let endDateString = datesArray[1]
        
        guard
            let startDateProcessed = startDateString.convertedDate,
            let endDateProcessed = endDateString.convertedDate
        else {
            return nil
        }
        
        return String(format: .houseInfoPeriodFormat, startDateProcessed, endDateProcessed)
    }
}

// MARK: - Helpers

private extension String {
    
    var convertedDate: String? {
        convert(from: .sourceDateFormat, to: .defaultDateFormat)
    }
    
    func formattedIfNotEmpty(with format: String) -> String? {
        
        withoutWhitespace.isEmpty
            ? nil
            : String(format: format, self)
    }
}

// MARK: - Constants

private extension String {
    
    static let sourceDateFormat = "dd.MM.yyyy"
}
