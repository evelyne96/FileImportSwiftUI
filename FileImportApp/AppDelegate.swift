//
//  AppDelegate.swift
//  FileImportApp
//
//  Created by Evelyne Suto on 31.01.2023.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppAnalytics.shared.start(with: AppCenterAnalytics())
        return true
    }
}
