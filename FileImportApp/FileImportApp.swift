//
//  FileImportApp.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 09/05/2021.
//

import SwiftUI

@main
struct FileImportApp: App {
    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            FileImportView()
        }
    }
}
