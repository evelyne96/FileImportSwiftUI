//
//  FileViewModel.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation

class FileViewModel: ObservableObject {
    var fileName: String {
        return fileURL.lastPathComponent
    }
    
    let fileURL: URL
    let exports: [FileExportViewModel]
    
    private var exportStatusLoaded = false
    private let supportedExportTypes: [FileExportType] = [.step, .stl, .obj]
    
    init(fileURL: URL) {
        self.fileURL = fileURL
        self.exports = supportedExportTypes.map { FileExportViewModel(type: $0, source: fileURL, exportStatus: .none) }
        
    }
    
    func loadExportStatusIfNeeded() {
        guard !exportStatusLoaded else { return }
        for fileExport in exports {
            if FileManager.fileExists(at: fileExport.url) && fileExport.exportStatus == .none {
                fileExport.exportStatus = .done
            }
        }
        exportStatusLoaded = true
    }
}

extension FileViewModel: Hashable, Identifiable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(fileURL)
    }
    
    static func == (lhs: FileViewModel, rhs: FileViewModel) -> Bool {
        return lhs.fileURL == rhs.fileURL
    }
}
