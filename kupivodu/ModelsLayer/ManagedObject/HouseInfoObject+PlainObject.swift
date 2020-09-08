//
//  HouseInfoObject+PlainObject.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import CoreData

extension HouseInfoObject {
    
    convenience init(context: NSManagedObjectContext, plainObject: HouseInfo) {
        self.init(context: context)
        
        city = plainObject.city
        address = plainObject.address
        building = plainObject.building
        part = plainObject.part
        letter = plainObject.letter
        period = plainObject.period
    }
}
