//
//  HouseListInteractorProtocols.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import RxSwift

protocol HouseListInteractorInput {
    
    func reload()
}

protocol HouseListInteractorOutput {
    
    var state: Observable<HouseListInteractorState> { get }
}
