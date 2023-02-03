//
//  FileView.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

struct FileExportDescLabel: View {
    @ObservedObject var vm: FileExportViewModel
    
    var body: some View {
        if vm.exportStatus == .done {
            Text(vm.name)
                .frame(minWidth: 35, maxWidth: 40)
                .font(.system(size: 12, weight: .bold, design: .default))
                .foregroundColor(.black)
                .background(Color.white.opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 1.5)
                        .stroke(Color.black, lineWidth: 1.5)
                )
        } else {
            EmptyView()
        }
    }
}

struct FileView: View {
    @State var vm: FileViewModel
    @State private var showPopover: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                FilePreviewView(vm: vm, compact: true)
                exportBadgeView()
                .offset(x: -10, y: -10)
            }
            
            Text(vm.fileName)
        }.onTapGesture { showPopover.toggle() }
         .popover(isPresented: $showPopover, attachmentAnchor: .point(.center), content: { FileDetailView(vm: vm) })
         .frame( maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            vm.loadExportStatusIfNeeded()
        }
    }

    func exportBadgeView() -> some View {
        LazyHGrid(rows: [.init(.fixed(40))], alignment: .bottom, spacing: 6) {
            ForEach(vm.exports, id: \.self) {
                FileExportDescLabel(vm: $0)
            }
        }
    }
}
