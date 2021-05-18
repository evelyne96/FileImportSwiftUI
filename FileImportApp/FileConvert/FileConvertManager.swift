//
//  FileConvertManager.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation

class FileConvertManager {
    static let shared = FileConvertManager()
    private let folder = Constants.exportFolder
    private let pendingOperations = PendingConvertionOperations()
    
    private init() { }
    
    func cancelPendingConversions() {
        pendingOperations.conversionQueue.cancelAllOperations()
    }
    
    func queueConversion(file: URL, dest: URL,
                         progress: @escaping (Double) -> ProgressAction,
                         completion: @escaping (ConversionResult) -> Void) -> FileConvertOperation? {
        
        let op = FileConvertOperation(source: file, destination: dest, progressBlock: progress, completion: completion)
        pendingOperations.conversionQueue.addOperation(op)
        
        return op
    }
    
    private func destinationURL(file: URL, exportType: FileExportType) -> URL? {
        let fileName = file.deletingPathExtension().lastPathComponent
        let filePath = "\(fileName)/\(fileName).\(exportType.description)"
        return FileManager.absoluteDocumentDirURL(filePath: filePath)
    }
}
