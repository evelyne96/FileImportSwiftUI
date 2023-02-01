//
//  FileExportType.swift
//  FileImportApp
//
//  Created by Evelyne Suto on 01.02.2023.
//

import Foundation

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
