//
//  TouchView.swift
//  Preferences
//
//  Settings > Accessibility > Touch
//

import SwiftUI

struct TouchView: View {
    // Variables
    @State private var shakeUndoEnabled = true
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "TOUCH".localize(table: table)) {
            Section {
                CustomNavigationLink("AIR_TOUCH_TITLE".localize(table: table), status: "OFF".localize(table: table), destination: AssistiveTouchView())
            }
            
            Section {
                Toggle("SHAKE_TO_UNDO".localize(table: table), isOn: $shakeUndoEnabled)
            } footer: {
                if UIDevice.iPhone {
                    Text("ShakeToUndoFooterTextFormat_IPHONE", tableName: table)
                } else if UIDevice.iPad {
                    Text("ShakeToUndoFooterTextFormat_IPAD", tableName: table)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TouchView()
    }
}
