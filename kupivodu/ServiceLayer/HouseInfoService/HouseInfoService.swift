//
//  HouseInfoService.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation

final class HouseInfoService {
    
    typealias HouseListFetchResult = (Result<[HouseInfo], Error>) -> Void
    
    // MARK: - Dependencies
    
    private let archiveHelper: ArchiveHelper
    private let networkService: NetworkService
    
    // MARK: - Service Init
    
    init(networkService: NetworkService) {
        self.archiveHelper = ArchiveHelper()
        self.networkService = networkService
    }
    
    // MARK: - Service Interface
    
    func obtainHouseInfo(completion: @escaping HouseListFetchResult) {
        
        networkService.request(HouseListEndpoint()) { [weak self] (result, error) in
            
            guard let file = result?.responseData.classifiers.first?.file else {
                completion(.failure(NetworkError.network))
                return
            }
            
            self?.decodeArchive(from: file, completion: completion)
        }
    }
    
    // MARK: - Private Methods
    
    private func decodeArchive(from file: Data, completion: @escaping HouseListFetchResult) {
        
        DispatchQueue.global().async { [weak self] in
            
            guard
                let houseInfoData = self?.archiveHelper.getFirstFileInArchive(data: file),
                let jsonData = houseInfoData.data(using: .utf8),
                let model = try? JSONDecoder().decode([HouseInfo].self, from: jsonData)
            else {
                completion(.failure(KVError.archiveDecode))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(model))
            }
        }
    }
}
