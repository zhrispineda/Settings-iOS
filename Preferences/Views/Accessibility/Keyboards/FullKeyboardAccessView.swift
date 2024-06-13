//
//  FullKeyboardAccessView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Full Keyboard Access
//

import SwiftUI

struct FullKeyboardAccessView: View {
    // Variables
    @State private var fullKeyboardAccessEnabled = false
    @State private var showingKeyboardAccessOffAlert = false
    @State private var increaseSizeEnabled = false
    @State private var highContrastEnabled = false
    
    var body: some View {
        CustomList(title: "Full Keyboard Access") {
            Section(content: {
                Toggle("Full Keyboard Access", isOn: $fullKeyboardAccessEnabled)
                    .alert("Important", isPresented: $showingKeyboardAccessOffAlert) {
                        Button("Yes") {}
                        Button("Cancel", role: .cancel) { fullKeyboardAccessEnabled = true }
                    } message: {
                        Text("Are you sure you want to turn off Full Keyboard Access?")
                    }
                    .onChange(of: fullKeyboardAccessEnabled) {
                        showingKeyboardAccessOffAlert = !fullKeyboardAccessEnabled
                    }
            }, footer: {
                Text("""
                    **Use an external keyboard to control your \(Device().model).**
                    \u{2022} To show Help: Tab H
                    \u{2022} To move forward: Tab
                    \u{2022} To move backward: \u{21E7} Tab
                    \u{2022} To activate: Space
                    \u{2022} To go Home: Fn H
                    \u{2022} To use the Control Center: Fn C
                    \u{2022} To use the Notification Center: Fn N
                    """)
            })
            
            Section {
                NavigationLink("Commands", destination: FullKeyboardAccessView())
            }
            
            Section(content: {
                CustomNavigationLink(title: "Auto-Hide", status: "15s", destination: AutoHideView())
                Toggle("Increase Size", isOn: $increaseSizeEnabled)
                Toggle("High Contrast", isOn: $highContrastEnabled)
                CustomNavigationLink(title: "Color", status: "Default", destination: KeyboardColorView())
            }, header: {
                Text("Appearance")
            })
        }
    }
}

#Preview {
    NavigationStack {
        FullKeyboardAccessView()
    }
}
