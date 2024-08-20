//
//  ApplePencilView.swift
//  Preferences
//
//  Settings > Apple Pencil
//

import SwiftUI

struct ApplePencilView: View {
    // Variables
    @State private var onlyDrawPencil = false
    @State private var scribbleEnabled = true
    
    var body: some View {
        CustomList(title: "Apple Pencil") {
            Section {
                Toggle("Only Draw with Apple Pencil", isOn: $onlyDrawPencil)
            } footer: {
                Text("When enabled, only Apple Pencil will draw. Your fingers will be used for scrolling instead.")
            }
            
            Section {
                Toggle("Scribble", isOn: $scribbleEnabled)
            } header: {
                Text("English")
            } footer: {
                Text("Use Apple Pencil to handwrite in any text area to convert it into type.")
            }
            
            if scribbleEnabled {
                Section {
                    Button("Try Scribble") {}
                }
            }
            
            Section {
                CustomNavigationLink(title: "Bottom Left Corner", status: "Screenshot", destination: SelectOptionList(title: "Bottom Left Corner", options: ["Quick Note", "Screenshot", "Off"], selected: "Screenshot"))
                CustomNavigationLink(title: "Bottom Right Corner", status: "Quick Note", destination: SelectOptionList(title: "Bottom Left Corner", options: ["Quick Note", "Screenshot", "Off"], selected: "Quick Note"))
            } header: {
                Text("Pencil Gestures")
            } footer: {
                Text("Actions when Apple Pencil is used to diagonally swipe from the corners of the screen.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ApplePencilView()
    }
}
