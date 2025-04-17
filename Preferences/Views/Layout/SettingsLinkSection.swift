//
//  SettingsLinkSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Link for iOS
struct SettingsLinkSection: View {
    @State private var showingSignInSheet = false
    var item: [SettingsItem<AnyView>]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if setting.id == "iCloud" {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        SLink(setting.id, color: setting.color, icon: setting.icon) {
                            setting.destination
                        }
                    }
                    .accessibilityLabel(setting.id)
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !tabletOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                    SLink(setting.id, color: setting.color, icon: setting.icon) {
                        setting.destination
                    }
                    .accessibilityLabel(setting.id)
                }
            }
        }
    }
}
