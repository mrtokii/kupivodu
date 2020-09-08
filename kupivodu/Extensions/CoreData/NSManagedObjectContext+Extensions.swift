//
//  NSManagedObjectContext+Extensions.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    func performAsync(_ closure: @escaping (_ privateContext: NSManagedObjectContext) -> Void) {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        context.perform {
            context.parent = self
            
            closure(context)
        }
    }
}
