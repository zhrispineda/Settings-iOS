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
                        SettingsLink(color: setting.color, icon: setting.icon, id: setting.id) {
                            setting.destination
                        }
                        .foregroundStyle(Color["Label"])
                    }
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !tabletOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                    SettingsLink(color: setting.color, icon: setting.icon, id: setting.id) {
                        setting.destination
                    }
                    .accessibilityLabel(setting.id)
                }
            }
        }
    }
}
