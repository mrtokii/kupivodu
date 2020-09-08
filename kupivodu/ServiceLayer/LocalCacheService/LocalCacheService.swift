//
//  LocalCacheService.swift
//  kupivodu
//
//  Created by Виталий Сальников on 08.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import CoreData
import RxSwift
import RxCocoa

final class LocalCacheService {
    
    private let storageService: StorageService
    
    private let disposeBag = DisposeBag()
    private let cacheRelay = BehaviorRelay<[HouseInfo]?>(value: nil)
    
    // MARK: - Public Properties
    
    var cache: [HouseInfo]? {
        cacheRelay.value
    }
    
    // MARK: - Public Inits
    
    init(storageService: StorageService) {
        self.storageService = storageService
        
        storageService.mainContextDriver
            .compactMap { $0 }
            .drive(onNext: { [weak self] _ in
                self?.fetchCache()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Public Methods
    
    func updateHouseList(with list: [HouseInfo]) {
        
        storageService.clear { [weak self] error in
            guard error == nil else {
                return
            }
            
            self?.storageService.mainContext?.performAsync { context in
                
                list.forEach {
                    let managedObject = HouseInfoObject(context: context, plainObject: $0)
                    context.insert(managedObject)
                }
                
                do {
                    try context.save()
                    self?.storageService.saveContext()
                } catch {
                    return
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchCache() {
        
        storageService.mainContext?.performAsync { [weak self] privateContext in
            
            let request: NSFetchRequest<HouseInfoObject> = HouseInfoObject.fetchRequest()
            let list = try? privateContext
                .fetch(request)
                .compactMap { HouseInfo(managedObject: $0) }
            
            self?.cacheRelay.accept(list)
        }
    }
}
