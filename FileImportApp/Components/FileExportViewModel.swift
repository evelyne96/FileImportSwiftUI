//
//  FileExport.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

enum FileExportType: CustomStringConvertible {
    case step
    case stl
    case obj
    
    var description: String {
        switch self {
        case .stl:
            return "STL"
        case .obj:
            return "OBJ"
        case .step:
            return "STEP"
        }
    }
}

enum FileExportStatus: Int {
    case none
    case progress
    case aborted
    case done
    
    var isInProg: Bool { return self == .progress }
    var image: String {
        switch self {
        case .none:
            return "arrowshape.turn.up.right.circle"
        case .progress:
            return "xmark.circle.fill"
        case .done, .aborted:
            return "square.and.arrow.up"
        }
    }
}

class FileExportViewModel: ObservableObject {
    let type: FileExportType
    @Published var exportStatus: FileExportStatus = .none {
        didSet {
            exportInProg = exportStatus.isInProg
            image = exportStatus.image
        }
    }
    var name: String { return type.description }
    let url: URL?
    
    @Published var exportProgressValue: Double
    @Published var exportInProg: Bool = false
    @Published var image: String
    @Published var sharePresented: Bool = false
    
    private let source: URL
    private var currentOp: FileConvertOperation?
    
    init(type: FileExportType, source: URL, exportStatus: FileExportStatus = .none) {
        self.type = type
        self.source = source
        self.exportStatus = exportStatus
        self.exportProgressValue = 0
        self.exportInProg = exportStatus.isInProg
        self.image = exportStatus.image
        self.url = FileExportViewModel.destinationURL(source: source, type: type)
    }
    
    func actionForCurrentState() {
        switch exportStatus {
        case .none:
            exportStatus = .progress
            startConversion()
        case .progress:
            exportStatus = .aborted
        case .done:
            AppAnalytics.track(.fileExported(type: type))
            sharePresented.toggle()
        case .aborted:
            exportStatus = .none
        }
    }
    
    private func startConversion() {
        guard let destination = url else { return }
        currentOp = FileConvertManager.shared.queueConversion(file: source, dest: destination) { [weak self] (prog) -> ProgressAction in
            self?.performOnMain { self?.exportProgressValue = prog }
            return self?.exportStatus == .aborted ? .abort : .cont
        } completion: { [weak self] (result) in
            self?.currentOp = nil
            var status: FileExportStatus = .done
            switch (result) {
            case .failure(_):
                status = .none
            default:
                break
            }
            
            self?.performOnMain { self?.exportStatus = status }
        }
    }
    
    private class func destinationURL(source: URL, type: FileExportType) -> URL? {
        let fileName = source.deletingPathExtension().lastPathComponent
        let filePath = "\(fileName)/\(fileName).\(type.description)"
        return FileManager.absoluteDocumentDirURL(filePath: filePath)
    }
}


extension FileExportViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
    
    static func == (lhs: FileExportViewModel, rhs: FileExportViewModel) -> Bool {
        return lhs.type == rhs.type && lhs.type == rhs.type
            && lhs.exportStatus == rhs.exportStatus
            && lhs.image == rhs.image
    }
}
