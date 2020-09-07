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
    
    private let stateRelay = BehaviorRelay<HouseListInteractorState>(value: .remote(.init(houses: [])))
    
    // MARK: - Public Init
    
    init(houseInfoService: HouseInfoService) {
        self.houseInfoService = houseInfoService
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
        stateRelay.accept(.error(error))
    }
    
    private func handleListSuccess(_ list: [HouseInfo]) {
        stateRelay.accept(.remote(.init(houses: list)))
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
