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

    private let networkService = NetworkService(with: .base)
    private lazy var houseInfoService = HouseInfoService(networkService: networkService)
    
    var window: UIWindow?
    
    private(set) lazy var mainWindow: UIWindow = {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        self.window = window
        
        return window
    }()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainWindow.rootViewController = HouseListModuleAssembly.createModule(houseInfoService: houseInfoService)
        
        return true
    }

    // MARK: - Core Data Saving support
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "kupivodu")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

