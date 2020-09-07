//
//  HouseListInteractorState.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

enum HouseListInteractorState: Equatable {
    
    static func == (lhs: HouseListInteractorState, rhs: HouseListInteractorState) -> Bool {
        
        switch (lhs, rhs) {
        case (.loading, .loading), (.error, .error):
            return true
        case let (.remote(lhsList), (.remote(rhsList))) where lhsList == rhsList:
            return true
        default:
            return false
        }
    }
    
    case loading
    case error(Error)
    case remote(HouseList)
}
