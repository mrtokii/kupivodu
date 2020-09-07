//
//  HouseListPresenterProtocols.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import RxCocoa

protocol HouseListPresenterOutput {
    
    var loadingDriver: Driver<Bool> { get }
    var errorDriver: Driver<String?> { get }
    var houseListDriver: Driver<[HouseInfo]> { get }
}
