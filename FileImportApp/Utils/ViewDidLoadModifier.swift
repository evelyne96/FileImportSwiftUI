//
//  ViewDidLoadModifier.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 17/05/2021.
//

import Foundation
import SwiftUI

// https://developer.apple.com/documentation/swiftui/viewmodifier
struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}
