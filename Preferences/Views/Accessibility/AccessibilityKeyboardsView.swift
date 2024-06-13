//
//  AccessibilityKeyboardsView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards
//

import SwiftUI

struct AccessibilityKeyboardsView: View {
    // Variables
    @State private var showLowercaseKeysEnabled = true
    
    var body: some View {
        CustomList(title: "Keyboards") {
            Section(content: {
                CustomNavigationLink(title: "Full Keyboard Access", status: "Off", destination: FullKeyboardAccessView())
            }, header: {
                Text("\nHardware Keyboards")
            }, footer: {
                Text("Use an external keyboard to control your \(Device().model).")
            })
            
            Section(content: {
                CustomNavigationLink(title: "Key Repeat", status: "On", destination: KeyRepeatView())
                CustomNavigationLink(title: "Sticky Keys", status: "Off", destination: StickyKeysView())
                CustomNavigationLink(title: "Slow Keys", status: "Off", destination: SlowKeysView())
            }, footer: {
                Text("Customize the typing experience when using an external keyboard.")
            })
            
            Section(content: {
                Toggle("Show Lowercase Keys", isOn: $showLowercaseKeysEnabled)
            }, header: {
                Text("Software Keyboards")
            }, footer: {
                Text("This affects keyboards that use the Shift key to switch between uppercase and lowercase letters.")
            })
        }
    }
}

#Preview {
    NavigationStack {
        AccessibilityKeyboardsView()
    }
}
