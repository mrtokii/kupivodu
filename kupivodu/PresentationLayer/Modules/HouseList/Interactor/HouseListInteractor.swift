//
//  HouseListInteractor.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class HouseListInteractor {
    
    private let houseInfoService: HouseInfoService
    private let cacheService: LocalCacheService
    
    private let stateRelay = BehaviorRelay<HouseListInteractorState>(value: .content(.init(houses: []), isCached: false))
    
    // MARK: - Public Init
    
    init(houseInfoService: HouseInfoService, cacheService: LocalCacheService) {
        self.houseInfoService = houseInfoService
        self.cacheService = cacheService
    }
    
    // MARK: - Public Methods
    
    func obtainHouseList() {
        
        stateRelay.accept(.loading)
        
        houseInfoService.obtainHouseInfo { [weak self] in
            switch $0 {
            case let .success(list):
                self?.handleListSuccess(list)
            case let .failure(error):
                self?.handle(error: error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handle(error: Error) {
        
        // Check if cache available
        if let cache = cacheService.cache {
            stateRelay.accept(.content(.init(houses: cache), isCached: true))
        } else {
            stateRelay.accept(.error(error))
        }
    }
    
    private func handleListSuccess(_ list: [HouseInfo]) {
        stateRelay.accept(.content(.init(houses: list), isCached: false))
        cacheService.updateHouseList(with: list)
    }
}

// MARK: - HouseListInteractorInput

extension HouseListInteractor: HouseListInteractorInput {
    
    func reload() {
        obtainHouseList()
    }
}

// MARK: - HouseListInteractorOutput

extension HouseListInteractor: HouseListInteractorOutput {
    
    var state: Observable<HouseListInteractorState> {
        stateRelay.asObservable()
    }
}
