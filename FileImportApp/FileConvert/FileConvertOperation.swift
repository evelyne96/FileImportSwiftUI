//
//  FileConvertOperation.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation

enum ConversionResult {
    case success
    case failure(Error)
}

class FileConvertOperation: AsyncOperation {
    private let source: URL
    private let destination: URL
    private let progressBlock: (Double) -> ProgressAction
    private let completion: (ConversionResult) -> Void
    private let converter: Converter
    
    init(source: URL, destination: URL,
         progressBlock: @escaping (Double) -> ProgressAction,
         completion: @escaping (ConversionResult) -> Void,
         converter: Converter = MockConverter()) {
        self.source = source
        self.destination = destination
        self.progressBlock = progressBlock
        self.completion = completion
        self.converter = converter
    }
    
    override func execute() {
        let destFolder = destination.deletingLastPathComponent()
        FileManager.createDirectoryIfNotExists(at: destFolder)
        do {
            try converter.convert(from: source, to: destination, progress: { [weak self] (progress) -> ProgressAction in
                if progress == 1.0 {
                    self?.executeCompleted?()
                    self?.completion(.success)
                }
                
                return self?.progressBlock(progress) ?? .abort
            })
        } catch {
            completion(.failure(error))
            executeCompleted?()
        }
    }
}

class PendingConvertionOperations {
    lazy var conversionQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ConvertionQueue queue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
}
