//
//  ApplePencilView.swift
//  Preferences
//
//  Settings > Apple Pencil
//

import SwiftUI

struct ApplePencilView: View {
    @AppStorage("OnlyDrawApplePencilToggle") private var onlyDrawPencil = false
    @AppStorage("ScribbleToggle") private var scribbleEnabled = true
    @State private var bottomLeftCornerSelection = "Screenshot"
    @State private var bottomRightCornerSelection = "Quick Note"
    @State private var showingSheet: Bool = false
    
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
                    Button("Try Scribble") {
                        showingSheet = true
                    }
                }
            }
            
            Section {
                SettingsLink("Bottom Left Corner", status: "Screenshot", destination: SelectOptionList("Bottom Left Corner", options: ["Quick Note", "Screenshot", "Off"], selected: $bottomLeftCornerSelection))
                SettingsLink("Bottom Right Corner", status: "Quick Note", destination: SelectOptionList("Bottom Right Corner", options: ["Quick Note", "Screenshot", "Off"], selected: $bottomRightCornerSelection))
            } header: {
                Text("Pencil Gestures")
            } footer: {
                Text("Actions when Apple Pencil is used to diagonally swipe from the corners of the screen.")
            }
        }
        .sheet(isPresented: $showingSheet) {
            NavigationStack {
                VStack {
                    Text("Try Scribble")
                        .font(.largeTitle)
                        .bold()
                    BundleControllerView("PencilSettings", controller: "PencilEducationViewController")
                }
                .toolbar {
                    Button("Done") {
                        showingSheet = false
                    }
                    .bold()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ApplePencilView()
    }
}
