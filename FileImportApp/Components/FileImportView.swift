//
//  ContentView.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 09/05/2021.
//

import SwiftUI

struct FileImportView: View {
    @State private var showImport: Bool = false
    private let importVM = FileImportViewModel()
    
    var body: some View {
        NavigationView {
            FileGridView(vm: importVM)
                .navigationBarItems(trailing: Button(action: { showImport.toggle() }) {
                Image(systemName: "plus")
                }.accessibilityLabel(AccessabilityID.plusButton))
        }.navigationViewStyle(StackNavigationViewStyle())
        .onLoad {
            importVM.reloadFiles()
        }
        .fileImporter(isPresented: $showImport, allowedContentTypes: [.shapr], allowsMultipleSelection: true) { (result) in
            switch result {
            case .success(let fileURLs):
                importVM.importFiles(files: fileURLs)
            case .failure(_):
                break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileImportView()
    }
}
