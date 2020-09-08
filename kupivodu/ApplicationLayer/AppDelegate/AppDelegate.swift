//
//  AppDelegate.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Services
    
    private let networkService = NetworkService(with: .base)
    private let storageService = StorageService()
    private lazy var cacheService = LocalCacheService(storageService: storageService)
    private lazy var houseInfoService = HouseInfoService(networkService: networkService)
    
    // MARK: - Windows
    
    var window: UIWindow?
    
    private(set) lazy var mainWindow: UIWindow = {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        self.window = window
        
        return window
    }()
    
    // MARK: - AppDelegate
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainWindow.rootViewController = HouseListModuleAssembly.createModule(houseInfoService: houseInfoService,
                                                                             cacheService: cacheService)
        
        return true
    }
}

