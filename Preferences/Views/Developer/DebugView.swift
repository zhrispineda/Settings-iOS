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
                LabeledContent("GeneralSettingsUI", value: "1200.2.500 (1.0)")
                LabeledContent("LegalAndRegulatorySettings", value: "1044.2.2 (1044.2.2)")
                LabeledContent("Preferences Framework", value: "5264.2.4 (1)")
                LabeledContent("Preferences UI Framework", value: "1308.2.502 (1)")
                LabeledContent("PrivacySettingsUI", value: "1203.2.501 (1.0)")
                LabeledContent("Settings", value: "207.2.501 (207.2.501)")
                LabeledContent("SettingsFoundation", value: "1080.2.7.500 (1.0)")
                LabeledContent("SettingsUIKitPrivate", value: "1066.2.6 (1.0)")
                LabeledContent("SoundsAndHapticsSettings", value: "1098.2.8 (1.0)")
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
