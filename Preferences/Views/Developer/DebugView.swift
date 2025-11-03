//
//  DebugView.swift
//  Preferences
//

import SwiftUI

struct DebugView: View {
    @Environment(PrimarySettingsListModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    #if DEBUG
    let debugBuild = true
    #else
    let debugBuild = false
    #endif
    
    var body: some View {
        List {
            Section {
                Button("Reset app navigation state.") {
                    model.path = []
                    model.selection = model.mainSettings.first
                    dismiss()
                }
            }

            Section {
                NavigationLink("Search") {}
                NavigationLink("Debug Settings") {}
            }
            
            Section("Info") {
                LabeledContent("Version", value: getBundleVersion(at: "/Applications/Preferences.app"))
                LabeledContent("Compiled With Debug", value: debugBuild ? "Yes" : "No")
            }
            
            Section("Bundles") {
                LabeledContent("GeneralSettingsUI", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Settings/GeneralSettingsUI.framework"))
                LabeledContent("LegalAndRegulatorySettings", value: getBundleVersion(at: "/System/Library/PreferenceBundles/LegalAndRegulatorySettings.bundle"))
                LabeledContent("Preferences Framework", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Preferences.framework"))
                LabeledContent("Preferences UI Framework", value: getBundleVersion(at: "/Applications/Preferences.app"))
                LabeledContent("PrivacySettingsUI", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Settings/PrivacySettingsUI.framework"))
                LabeledContent("Settings", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Settings.framework"))
                LabeledContent("SettingsFoundation", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/SettingsFoundation.framework"))
                LabeledContent("SettingsUIKitPrivate", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Settings/SettingsUIKitPrivate.framework"))
                LabeledContent("SoundsAndHapticsSettings", value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Settings/SoundsAndHapticsSettings.framework"))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    IconView("com.apple.Preferences")
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
    
    private func getBundleVersion(at path: String) -> String {
        var bundlePath = ""

        if UIDevice.IsSimulated {
            let build = MGHelper.read(key: "mZfUC7qo4pURNhyMHZ62RQ") ?? ""
            
            bundlePath = "/Library/Developer/CoreSimulator/Volumes/iOS_\(build)/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS \(UIDevice.current.systemVersion == "26.0.1" ? "26.0" : UIDevice.current.systemVersion).simruntime/Contents/Resources/RuntimeRoot\(path)"
        } else {
            bundlePath = path
        }
        
        guard let bundle = Bundle(path: bundlePath),
              let buildVersion = bundle.infoDictionary?["CFBundleVersion"] as? String,
              let shortVersion = bundle.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "Error"
        }
        
        return "\(buildVersion) (\(shortVersion))"
    }
}

#Preview {
    NavigationStack {
        DebugView()
            .environment(PrimarySettingsListModel())
    }
}
