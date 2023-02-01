//
//  FilePreviewView.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

struct FilePreviewView: View {
    @State var vm: FileViewModel
    @State var compact: Bool
    
    private var minHeight: CGFloat { compact ? 250 : 300 }
    private var maxHeight: CGFloat { compact ? 350 : 400 }
    private var cornerRad: CGFloat { compact ? 10 : 0 }
    
    var body: some View {
        Color(UIColor.random(with: vm.fileName))
        .frame(minHeight: minHeight, maxHeight: maxHeight)
        .cornerRadius(cornerRad)
    }
}
