//
//  HoverTextView.swift
//  Preferences
//
//  Settings > Accessibility > Hover Text
//

import SwiftUI

struct HoverTextView: View {
    // Variables
    @State private var hoverTextEnabled = false
    @State private var textColor = Color.black
    @State private var insertionPointColor = Color.black
    @State private var backgroundColor = Color.black
    @State private var borderColor = Color.black
    @State private var activationLockEnabled = false
    
    var body: some View {
        CustomList(title: "Hover Text") {
            Section {
                Toggle("Hover Text", isOn: $hoverTextEnabled)
            } footer: {
                Text("Display a large-text view of items under the pointer.")
            }
            
            Section {
                CustomNavigationLink(title: "Display Mode", status: "Top", destination: SelectOptionList(title: "Display Mode", options: ["Inline", "Top", "Bottom"], selected: "Top"))
                CustomNavigationLink(title: "Scrolling Speed", status: "Default", destination: SelectOptionList(title: "Scrolling Speed", options: ["Slowest", "Slower", "Default", "Faster", "Fastest"], selected: "Default"))
                CustomNavigationLink(title: "Font", status: "Default", destination: HoverTextFontView())
                CustomNavigationLink(title: "Size", status: "On", destination: HoverTextSizeView())
            } header: {
                Text("Text")
            }
            
            Section {
                ColorPicker("Text Color", selection: $textColor)
                ColorPicker("Insertion Point Color", selection: $insertionPointColor)
                ColorPicker("Background Color", selection: $backgroundColor)
                ColorPicker("Border Color", selection: $borderColor)
            } header: {
                Text("Colors")
            }
            
            Section {
                CustomNavigationLink(title: "Activation Modifier", status: "⌃ Control", destination: SelectOptionList(title: "Activation Modifier", options: ["⌃ Control", "⌥ Option", "⌘ Command"], selected: "⌃ Control"))
                Toggle("Activation Lock", isOn: $activationLockEnabled)
            } header: {
                Text("Control")
            } footer: {
                Text("Triple-press the activation modifier to lock.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        HoverTextView()
    }
}
