//
//  HouseListModuleAssembly.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

enum HouseListModuleAssembly {
    
    static func createModule(houseInfoService: HouseInfoService,
                             cacheService: LocalCacheService) -> HouseListViewController {
        
        let interactor = HouseListInteractor(houseInfoService: houseInfoService, cacheService: cacheService)
        let presenter = HouseListPresenter()
        let view = HouseListViewController()
        
        presenter.bindInteractor(interactor)
        
        view.presenterOutput = presenter
        view.actionInput = interactor
        
        return view
    }
}
