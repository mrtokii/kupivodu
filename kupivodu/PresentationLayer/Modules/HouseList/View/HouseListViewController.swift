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

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let loadingView = LoadingView()
    private let errorPlaceholder = PlaceholderView()
    
    private var dataSource: [HouseInfo] = []
    
    // MARK: - Module Setup
    
    var actionInput: HouseListInteractorInput?
    var presenterOutput: HouseListPresenterOutput?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
        updateTable()
        
        if let presenter = presenterOutput {
            bindPresenter(presenter)
        }
        
        actionInput?.reload()
    }
    
    // MARK: - Private Methods
    
    private func bindPresenter(_ output: HouseListPresenterOutput) {
        
        output.loadingDriver
            .map { !$0 }
            .drive(loadingView.rx.isHidden)
            .disposed(by: disposeBag)
        
        output.errorDriver
            .drive(onNext: { [weak self] in
                if let errorDescription = $0 {
                    self?.errorPlaceholder.configure(with: .init(error: errorDescription))
                    self?.errorPlaceholder.isHidden = false
                } else {
                    self?.errorPlaceholder.isHidden = true
                }
            })
            .disposed(by: disposeBag)
        
        output.houseListDriver
            .drive(onNext: { [weak self] list in
                self?.dataSource = list
                self?.updateTable()
            })
            .disposed(by: disposeBag)
        
        output.isCachedDriver
            .drive(onNext: { [weak self] in
                
                // Color means the values are from local cache
                self?.view.backgroundColor = $0 ? .cyan : .white
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        
        let stateViews = [tableView, loadingView, errorPlaceholder]
        
        view.backgroundColor = .white
        view.addSubviews(stateViews)
        
        tableView.backgroundColor = .clear
                
        stateViews.forEach {
            $0.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        errorPlaceholder.onRetry = { [weak self] in
            self?.actionInput?.reload()
        }
    }
    
    private func setupTableView() {
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.register(HouseInfoCell.self, forCellReuseIdentifier: Constants.houseCellId)
    }
    
    private func updateTable() {
        tableView.reloadData()
    }
    
    @objc private func reload() {
        actionInput?.reload()
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension HouseListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.houseCellId) as? HouseInfoCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: dataSource[indexPath.row])
        
        return cell
    }
}

// MARK: - Constants

private enum Constants {
    
    static let houseCellId = String(describing: HouseInfoCell.self)
}
