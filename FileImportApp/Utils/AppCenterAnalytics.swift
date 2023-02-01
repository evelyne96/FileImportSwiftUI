//
//  AnalyticsClient.swift
//  FileImportApp
//
//  Created by Evelyne Suto on 01.02.2023.
//

import Foundation
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class AppCenterAnalytics: AnalyticsClient {
    func start() {
        AppCenter.start(withAppSecret: try? Configuration.value(for: "APPCENTER_KEY"), services: [Analytics.self, Crashes.self])
    }
    
    func track(_ description: String, properties: [String : String]?) {
        Analytics.trackEvent(description, withProperties: properties)
    }
}
