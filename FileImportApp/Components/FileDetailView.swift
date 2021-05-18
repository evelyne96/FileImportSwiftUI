//
//  FileDetailView.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

struct FileExportRowView: View {
    @ObservedObject var fileExport: FileExportViewModel
    
    var body: some View {
        HStack {
            Text(fileExport.name)
            if fileExport.exportInProg {
                Spacer()
                ProgressView(value: fileExport.exportProgressValue)
                Spacer()
            } else {
                Spacer()
            }
            Button(action: { fileExport.actionForCurrentState() }) { Image(systemName: fileExport.image) }
            .sheet(isPresented: Binding(get: { fileExport.sharePresented }, set: { fileExport.sharePresented = $0 }), content: {
                ShareSheet(activityItems: fileExport.url != nil ? [fileExport.url!] : [])
            })
        }.buttonStyle(PlainButtonStyle())
    }
}

struct FileDetailView: View {
    @ObservedObject var vm: FileViewModel
    var body: some View {
        NavigationView {
            VStack {
                FilePreviewView(vm: vm, compact: false)
                List(vm.exports, id: \.self) { export in
                    FileExportRowView(fileExport: export)
                }
            }
            .navigationBarTitle(vm.fileName, displayMode: .inline)
        }
        .frame(minWidth: 450, minHeight: 550)
    }
}
