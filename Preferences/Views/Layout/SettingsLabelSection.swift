//
//  SettingsLabelSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Sidebar Label for iPadOS
struct SettingsLabelSection: View {
    @Environment(StateManager.self) private var stateManager
    @Binding var selection: SettingsItem?
    @Binding var id: UUID
    @State private var showingSignInSheet = false
    let item: [SettingsItem]
    
    var body: some View {
        Section {
            ForEach(item) { setting in
                if setting.type == .icloud {
                    Button {
                        showingSignInSheet.toggle()
                    } label: {
                        SLabel(setting.title, color: setting.color, icon: setting.icon)
                    }
                    .foregroundStyle(.primary)
                    .sheet(isPresented: $showingSignInSheet) {
                        NavigationStack {
                            SelectSignInOptionView()
                                .interactiveDismissDisabled()
                        }
                    }
                } else if !stateManager.phoneOnly.contains(setting.title) && requiredCapabilities(capability: setting.capability) {
                    Button {
                        if selection != setting {
                            selection = setting
                        }
                    } label: {
                        SLabel(setting.title, color: setting.color, icon: setting.icon)
                    }
                    .foregroundStyle(selection == setting ? .blue : .primary)
                    .listRowBackground(
                        Color(selection == setting ? (UIDevice.IsSimulator ? .blue : .selected) : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                    )
                }
            }
        }
    }
}
