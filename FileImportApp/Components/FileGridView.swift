//
//  FileImportView.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

// https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html

struct FileGridView: View {
    @ObservedObject var vm: FileImportViewModel
    var items: [GridItem] = [.init(.adaptive(minimum: 250, maximum: 450))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: items, alignment: .center, spacing: 10) {
                ForEach(vm.importedFiles, id: \.self) {
                    FileView(vm: $0)
                }
            }
            .padding(.all, 10)
        }
    }
}
