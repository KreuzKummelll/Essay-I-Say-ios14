//
//  ClarifyingButton.swift
//  Essay I Say-ios14
//
//  Created by Smalli ARM on 7/2/20.
//

import SwiftUI

struct ClarifyingButton: View {
    
    var textLabel: String
    var systemImageName: String
    
    var action: ()

    
    @State private var index: Int = 0
    
    var body: some View {
        Button {
            
        } label: {
            return Group {
                if index == 0 {
                    Text(textLabel)
                } else {
                    Image(systemName: systemImageName)
                }
            }
        }
    }
}

struct ClarifyingButton_Previews: PreviewProvider {
    static var previews: some View {
        ClarifyingButton(textLabel: "Delete", systemImageName: "multiply", action: print("clarifying button") )
    }
    
   static func something() {
        
    }
}
