//
//  FileImportViewModel.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

class FileImportViewModel: ObservableObject {
    private let folder: String
    @Published var importedFiles: [FileViewModel] = []
    
    init (folder: String = Constants.importFolder) {
        self.folder = folder
    }
    
    func reloadFiles() {
        importedFiles = FileManager.loadFileURLs(from: folder).map { FileViewModel(fileURL: $0) }
    }
    
    func importFiles(files: [URL]) {
        let savedFiles = FileManager.save(files: files, folder: folder)
        savedFiles.forEach { url in
            let importedFile = importedFiles.first { $0.fileURL == url }
            if importedFile == nil {
                importedFiles.append(FileViewModel(fileURL: url))
            }
        }
    }
}
