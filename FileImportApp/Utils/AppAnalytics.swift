//
//  Analytics.swift
//  FileImportApp
//
//  Created by Evelyne Suto on 31.01.2023.
//

import Foundation
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

enum AppAnalytics {
    enum Event: CustomStringConvertible {
        case fileExported(type: FileExportType)
        
        var description: String {
            switch self {
            case .fileExported: return "file_exported"
            }
        }
        
        var properties: [String: String]? {
            switch self {
            case .fileExported(let type): return ["type": type.description]
            }
        }
    }
    
    static func start() {
        AppCenter.start(withAppSecret: try? Configuration.value(for: "APPCENTER_KEY"), services: [Analytics.self, Crashes.self])
    }
    
    static func track(_ event: Event) {
        Analytics.trackEvent(event.description, withProperties: event.properties)
    }
}
