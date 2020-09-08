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
        case let (.content(lhsData), (.content(rhsData))):
            if lhsData.0 == rhsData.0, lhsData.isCached == rhsData.isCached {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    case loading
    case error(Error)
    case content(HouseList, isCached: Bool)
}
