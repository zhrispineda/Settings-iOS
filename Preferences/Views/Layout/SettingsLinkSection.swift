//
//  SettingsLinkSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Link for iOS
struct SettingsLinkSection: View {
    @Environment(StateManager.self) private var stateManager
    @State private var showingSignInSheet = false
    var item: [SettingsItem]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if setting.type == .icloud {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        SLink(setting.title, color: setting.color, icon: setting.icon) {
                            setting.destination
                        }
                    }
                    .accessibilityLabel(setting.title)
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !stateManager.tabletOnly.contains(setting.title) && requiredCapabilities(capability: setting.capability) {
                    SLink(setting.title, color: setting.color, icon: setting.icon) {
                        setting.destination
                    }
                    .accessibilityLabel(setting.title)
                }
            }
        }
    }
}
