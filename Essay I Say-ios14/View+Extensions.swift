//
//  View+Extensions.swift
//  Essay I Say-ios14
//
//  Created by Smalli ARM on 7/1/20.
//

import SwiftUI


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
