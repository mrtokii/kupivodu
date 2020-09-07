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
            .map { [weak self] state -> String? in
                if case let .error(error) = state {
                    return self?.errorText(of: error)
                } else {
                    return nil
                }
            }
            .bind(to: errorRelay)
            .disposed(by: disposeBag)
        
        output.state
            .compactMap { state -> [HouseInfo]? in
                if case let .remote(list) = state {
                    return list.houses
                } else {
                    return nil
                }
            }
            .bind(to: houseListRelay)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Private Methods
    
    private func errorText(of error: Error) -> String? {
        return "Error!"
    }
}

// MARK: - Output

extension HouseListPresenter: HouseListPresenterOutput {
    
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
