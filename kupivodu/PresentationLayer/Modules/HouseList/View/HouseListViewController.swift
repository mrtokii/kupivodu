//
//  HouseListViewController.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit

final class HouseListViewController: UIViewController {

    // MARK: - Module Setup
    
    var actionInput: HouseListInteractorInput?
    
    func bindPresenter(_ output: HouseListPresenterOutput) {
        
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}
