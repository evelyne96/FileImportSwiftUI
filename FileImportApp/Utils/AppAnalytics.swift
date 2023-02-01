//
//  Analytics.swift
//  FileImportApp
//
//  Created by Evelyne Suto on 31.01.2023.
//

import Foundation

protocol AnalyticsClient {
    func start()
    func track(_ description: String, properties: [String: String]?)
}

extension AnalyticsClient {
    func track(_ description: String) {
        track(description, properties: nil)
    }
}

class AppAnalytics {
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
    
    static var shared: AppAnalytics = { .init() }()
    private var client: AnalyticsClient?
    
    func start(with client: AnalyticsClient) {
        self.client = client
        client.start()
    }
    
    func stop() {
        client = nil
    }
    
    func track(_ event: Event) {
        client?.track(event.description, properties: event.properties)
    }
}
