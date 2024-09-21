//
//  KeyboardsTypingView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards & Typing
//

import SwiftUI

struct KeyboardsTypingView: View {
    // Variables
    @State private var showLowercaseKeys = true
    
    var body: some View {
        CustomList(title: "Keyboards & Typing") {
            Section {
                CustomNavigationLink(title: "Hover Typing", status: "Off", destination: EmptyView())
            } footer: {
                Text("Display words in larger text while typing.")
            }
            
            Section {
                NavigationLink("Typing Feedback") {}
            }
            
            Section {
                CustomNavigationLink(title: "Full Keyboard Access", status: "Off", destination: EmptyView())
            } header: {
                Text("Hardware Keyboards")
            } footer: {
                Text("Use an external keyboard to control your \(UIDevice.current.model).")
            }
            
            Section {
                CustomNavigationLink(title: "Key Repeat", status: "On", destination: EmptyView())
                CustomNavigationLink(title: "Sticky Keys", status: "Off", destination: EmptyView())
                CustomNavigationLink(title: "Slow Keys", status: "Off", destination: EmptyView())
            } footer: {
                Text("Customize the typing experience when using an external keyboard.")
            }
            
            Section {
                Toggle("Show Lowercase Keys", isOn: $showLowercaseKeys)
            } header: {
                Text("Software Keyboards")
            } footer: {
                Text("This affects keyboards that use the Shift key to switch between uppercase and lowercase letters.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardsTypingView()
    }
}
