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

enum TestError: Error {
    case test
}

final class HouseListInteractor {
    
    private let stateRelay = BehaviorRelay<HouseListInteractorState>(value: .remote(.init(houses: [])))
}

extension HouseListInteractor: HouseListInteractorInput {
    
    func test() {
        if case .loading = stateRelay.value {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.stateRelay.accept(.remote(.init(houses: [
                    .init(address: "Addr1"),
                    .init(address: "Arrd2")
                ])))
            }
        }
        
        if case .remote = stateRelay.value {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.stateRelay.accept(.error(TestError.test))
            }
        }
        
        if case .error = stateRelay.value {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.stateRelay.accept(.loading)
            }
        }
    }
}

extension HouseListInteractor: HouseListInteractorOutput {
    
    var state: Observable<HouseListInteractorState> {
        stateRelay.asObservable()
    }
}
