//
//  DebugView.swift
//  Preferences
//

import SwiftUI

struct DebugView: View {
    // Variables
    @Environment(\.dismiss) private var dismiss
    #if DEBUG
    let debugBuild = true
    #else
    let debugBuild = false
    #endif
    
    var body: some View {
        List {
            Section {
                Button("Reset app navigation state.") {}
            }
            
            Section {
                NavigationLink("Search") {}
                NavigationLink("Debug Settings") {}
            }
            
            Section("Info") {
                LabeledContent("Version", value: "1308.2.502 (1)")
                LabeledContent("Compiled With Debug", value: debugBuild ? "Yes" : "No")
            }
            
            Section("Bundles") {
                LabeledContent("GeneralSettingsUI", value: "1200.1.5 (1.0)")
                LabeledContent("LegalAndRegulatorySettings", value: "1044.1.1 (1044.1.1)")
                LabeledContent("Preferences Framework", value: "5264.1.5 (1)")
                LabeledContent("Preferences UI Framework", value: "1308.2.502 (1)")
                LabeledContent("PrivacySettingsUI", value: "1203.1.5 (1.0)")
                LabeledContent("Settings", value: "207.1.3.100 (207.1.3.100)")
                LabeledContent("SettingsFoundation", value: "1080.1.2 (1.0)")
                LabeledContent("SettingsUIKitPrivate", value: "1066.1.3 (1.0)")
                LabeledContent("SoundsAndHapticsSettings", value: "1098.1.3 (1.0)")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(.appleSettings)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    Text("Debug")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugView()
    }
}
