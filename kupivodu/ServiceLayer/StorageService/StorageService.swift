//
//  StorageService.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import CoreData
import RxCocoa

final class StorageService {
    
    private let contextRelay = BehaviorRelay<NSManagedObjectContext?>(value: nil)
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "kupivodu")
        container.loadPersistentStores(completionHandler: { [weak self] (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("CoreData error \(error), \(error.userInfo)")
            }
            
            self?.contextRelay.accept(container.viewContext)
        })
        return container
    }()
    
    // MARK: - Public Properties

    var mainContextDriver: Driver<NSManagedObjectContext?> {
        contextRelay.asDriver()
    }
    
    var mainContext: NSManagedObjectContext? {
        contextRelay.value
    }
    
    // MARK: - Public Init
    
    init() {
        // Load container
        _ = persistentContainer
    }
    
    // MARK: - Public Methods

    func saveContext() {
        guard let context = mainContext else {
            return
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("CoreData error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clear(_ completion: @escaping (Error?) -> Void) {

        guard let context = mainContext else {
            return
        }
        
        let names = persistentContainer.managedObjectModel.entities.compactMap { $0.name }

        context.performAsync { privateContext in
            names.forEach { name in
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                _ = try? privateContext.execute(batchDeleteRequest)
            }
            
            var savingError: Error?
            do {
                try privateContext.save()
            }
            catch {
                savingError = error
            }
            
            context.perform {
                completion(savingError)
            }
        }
    }
}

