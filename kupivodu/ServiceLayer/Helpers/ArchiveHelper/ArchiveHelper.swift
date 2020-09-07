//
//  ArchiveHelper.swift
//  kupivodu
//
//  Created by Виталий Сальников on 07.09.2020.
//  Copyright © 2020 Vitaliy Salnikov. All rights reserved.
//

import Foundation
import Zip

final class ArchiveHelper {
    
    // MARK: - Service Interface
    
    func getFirstFileInArchive(data: Data) -> String? {
        
        guard let firstFile = unzip(base64encoded: data)?.first else {
            return nil
        }
        
        return try? String(contentsOf: firstFile, encoding: .utf8)
    }
    
    // MARK: - Private Methods
    
    private func unzip(base64encoded data: Data) -> [URL]? {
        
        let fileManager = FileManager.default
        guard let path = try? fileManager.url(for: .cachesDirectory,
                                              in: .userDomainMask,
                                              appropriateFor: nil,
                                              create: true) else {
            return nil
        }
        
        let filePath = path.appendingPathComponent(.tempArchiveFileName)
        
        do {
            try data.write(to: filePath)
            
            let unzipDirectory = try Zip.quickUnzipFile(filePath)
            let fileList = try fileManager.contentsOfDirectory(at: unzipDirectory,
                                                               includingPropertiesForKeys: [],
                                                               options: [])

            return fileList
            
        } catch {
            return nil
        }
    }
}

// MARK: - Constants

private extension String {
    
    static let tempArchiveFileName = "temp.zip"
}
