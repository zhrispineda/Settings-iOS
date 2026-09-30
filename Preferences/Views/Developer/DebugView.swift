//
//  DebugView.swift
//  Preferences
//

import SwiftUI

struct DebugView: View {
    @Environment(PrimarySettingsListModel.self) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var presentationItem = "applicationDebugSettings"
    private let presentationItems = [
        "None",
        "securityResearchDevice",
        "supervisedDevice",
        "primaryAppleAccountSignIn",
        "applicationDebugSettings",
        "appleAccountNetworkReachabilityAlert",
        "followUpNetworkReachabilityAlert",
        "followUpModal",
        "engagementLink",
        "finishSetup",
        "protoAccountSignIn",
        "tapToRadarAlert"
    ]
    #if DEBUG
    let debugBuild = true
    #else
    let debugBuild = false
    #endif
    
    var body: some View {
        List {
            Section("Device Quick Actions") {
                Picker("", selection: .constant(0)) {
                    Button("", systemImage: "power") {}.labelStyle(.iconOnly)
                    Button("", systemImage: "restart") {}.labelStyle(.iconOnly)
                    Button("", systemImage: "arrow.trianglehead.counterclockwise.rotate.90") {}.labelStyle(.iconOnly)
                }
                .pickerStyle(.segmented)
            }
            .listRowBackground(Color.clear)
            
            Section("Navigation") {
                NavigationLink("Default Settings App") {
                    CustomList(title: "Default Settings App") {
                        Picker("", selection: .constant(1)) {
                            Text("Settings").tag(1)
                            Text("Old Settings").tag(2)
                        }
                        .pickerStyle(.inline)
                    }
                }
                NavigationLink("Navigation State") {
                    CustomList(title: "Navigation State") {
                        Section("Actions") {
                            Button("Reset to Default Navigation State") {
                                model.path = []
                                if UIDevice.iPad {
                                    model.selection = model.mainSettings.first
                                }
                                dismiss()
                            }
                        }
                        
                        Section {
                            Picker("Presented Item", selection: $presentationItem) {
                                ForEach(presentationItems, id: \.self) {
                                    Text($0)
                                }
                            }
                            .onChange(of: presentationItem) {
                                dismiss()
                            }
                        } header: {
                            Text("Presentations")
                        } footer: {
                            Text("Drives navigationSplitView.presentedItem. Cases with associated values use dummy data.")
                        }
                        
                        Section("Current State") {
                            LabeledContent("Sidebar Selection", value: "None")
                            LabeledContent("Navigation Path Item Count", value: "\(model.path.count)")
                        }
                    }
                }
            }
            
            Section("Application/Framework Debugging") {
                NavigationLink("Sidebar Content Overrides", destination: DebugOverridesView().environment(model))
                NavigationLink("Preferences Debug", destination: DebugSettingsView().environment(model))
                NavigationLink("Search", destination: DebugSearchView())
            }
            
            Section("Application Info") {
                LabeledContent(
                    "Version",
                    value: getBundleVersion(at: "/System/Library/PrivateFrameworks/Settings.framework")
                )
                LabeledContent(
                    "Compiled With Debug",
                    value: debugBuild ? "Yes" : "No"
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    IconView("com.apple.Preferences")
                    Text("Debug")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(role: .close) {
                    dismiss()
                }
            }
        }
    }
    
    private func getBundleVersion(at path: String = "") -> String {
        var bundlePath = ""

        if UIDevice.IsSimulated {
            bundlePath = "\(UIDevice.RuntimePath)\(path)"
        } else {
            bundlePath = path
        }
        
        if path.isEmpty {
            let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Error"
            let shortVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Error"
            return "\(buildVersion) (\(shortVersion))"
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
