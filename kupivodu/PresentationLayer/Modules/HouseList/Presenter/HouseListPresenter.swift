//
//  HouseListPresenter.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import RxSwift
import RxCocoa

final class HouseListPresenter {
    
    private let disposeBag = DisposeBag()
    
    private let loadingRelay = BehaviorRelay(value: false)
    private let isCachedRelay = BehaviorRelay(value: false)
    private let errorRelay = BehaviorRelay<String?>(value: nil)
    private let houseListRelay = BehaviorRelay<[HouseInfo]>(value: [])
    
    // MARK: - Module Setup
    
    func bindInteractor(_ output: HouseListInteractorOutput) {
        
        output.state
            .map { $0 == .loading }
            .distinctUntilChanged()
            .bind(to: loadingRelay)
            .disposed(by: disposeBag)
        
        output.state
            .map { state -> String? in
                if case let .error(error) = state {
                    return error.description
                } else {
                    return nil
                }
            }
            .bind(to: errorRelay)
            .disposed(by: disposeBag)
        
        output.state
            .compactMap { state -> [HouseInfo]? in
                if case let .content(list, _) = state {
                    return list.houses
                } else {
                    return nil
                }
            }
            .bind(to: houseListRelay)
            .disposed(by: disposeBag)
        
        output.state
            .compactMap { state -> Bool in
                if case let .content(_, isCached) = state {
                    return isCached
                } else {
                    return false
                }
            }
            .bind(to: isCachedRelay)
            .disposed(by: disposeBag)
    }
}

// MARK: - Output

extension HouseListPresenter: HouseListPresenterOutput {
    
    var isCachedDriver: Driver<Bool> {
        isCachedRelay.asDriver()
    }
    
    var loadingDriver: Driver<Bool> {
        loadingRelay.asDriver()
    }
    
    var errorDriver: Driver<String?> {
        errorRelay.asDriver()
    }
    
    var houseListDriver: Driver<[HouseInfo]> {
        houseListRelay.asDriver()
    }
}
