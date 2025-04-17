//
//  SettingsLabelSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Sidebar Label for iPadOS
struct SettingsLabelSection: View {
    @State private var showingSignInSheet = false
    @Binding var selection: SettingsModel?
    @Binding var id: UUID
    var item: [SettingsItem<AnyView>]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if setting.id == "iCloud" {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        SLabel(setting.id, color: setting.color, icon: setting.icon)
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !phoneOnly.contains(setting.id) && requiredCapabilities(capability: setting.capability) {
                    Button {
                        id = UUID() // Reset destination
                        selection = setting.type
                    } label: {
                        SLabel(setting.id, color: setting.color, icon: setting.icon)
                    }
                    .foregroundStyle(.primary)
                    .listRowBackground(selection == setting.type ? (UIDevice.IsSimulator ? Color.blue : .selected) : nil)
                }
            }
        }
    }
}
