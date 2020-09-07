//
//  HouseListViewController.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class HouseListViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    private let loadingLabel = UILabel()
    private let errorLabel = UILabel()
    private let listLabel = UILabel()
    private let button = UIButton()
    
    private let stack = UIStackView()
    
    // MARK: - Module Setup
    
    var actionInput: HouseListInteractorInput?
    var presenterOutput: HouseListPresenterOutput?

    private func bindPresenter(_ output: HouseListPresenterOutput) {
        
        output.loadingDriver
            .map { $0 ? "loading" : "not loading" }
            .drive(onNext: { [weak self] in
                self?.loadingLabel.text = $0
            })
            .disposed(by: disposeBag)
        
        output.errorDriver
            .drive(onNext: { [weak self] in
                if let text = $0 {
                    self?.errorLabel.text = text
                } else {
                    self?.errorLabel.text = "no error"
                }
            })
            .disposed(by: disposeBag)
        
        output.houseListDriver
            .drive(onNext: { [weak self] list in
                self?.listLabel.text = list.map { $0.address }.joined(separator: "/")
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stack)
        
        stack.addArrangedSubview(loadingLabel)
        stack.addArrangedSubview(errorLabel)
        stack.addArrangedSubview(listLabel)
        stack.addArrangedSubview(button)
        
        stack.axis = .vertical
        
        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        button.setTitle("test", for: .normal)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
        
        if let presenter = presenterOutput {
            bindPresenter(presenter)
        }
        
        view.backgroundColor = .yellow
    }
    
    @objc private func buttonPress() {
        actionInput?.test()
    }
}
