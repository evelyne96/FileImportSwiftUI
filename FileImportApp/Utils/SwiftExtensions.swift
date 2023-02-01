//
//  SwiftExtensions.swift
//  FileImportApp
//
//  Created by Suto, Evelyne on 11/05/2021.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers.UTType

extension UTType {
    public static let shapr = UTType(filenameExtension: "shapr")!
}

//https://stackoverflow.com/questions/29779128/how-to-make-a-random-color-with-swift
extension UIColor {
    class func random(with seed: String) -> UIColor {
        let total: Int = seed.unicodeScalars.map { Int(UInt32($0)) }.reduce(0, +)
        
        srand48(total * 255)
        let r = CGFloat(drand48())
        
        srand48(total)
        let g = CGFloat(drand48())
        
        srand48(total / 255)
        let b = CGFloat(drand48())
        
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

extension ObservableObject {
    func performOnMain(block: @escaping () -> (Void)) {
        DispatchQueue.main.async {
            block()
        }
    }
}

extension View {
    func accessibilityLabel(_ label: AccessabilityID) -> ModifiedContent<Self, AccessibilityAttachmentModifier> {
        return accessibilityLabel(label.rawValue)
    }
}
