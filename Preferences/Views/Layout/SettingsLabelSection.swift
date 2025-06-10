//
//  SettingsLabelSection.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Settings Sidebar Label for iPadOS
struct SettingsLabelSection: View {
    @Binding var selection: SettingsModel?
    @Binding var id: UUID
    @State private var showingSignInSheet = false
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
                    .foregroundStyle(selection == setting.type ? .blue : .primary)
                    .listRowBackground(
                        Color(selection == setting.type ? (UIDevice.IsSimulator ? .blue : .selected) : .clear)
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                    )
                }
            }
        }
    }
}
