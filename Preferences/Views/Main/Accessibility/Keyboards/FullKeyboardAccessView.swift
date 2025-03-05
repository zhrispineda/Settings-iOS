//
//  FullKeyboardAccessView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards > Full Keyboard Access
//

import SwiftUI

struct FullKeyboardAccessView: View {
    // Variables
    @State private var fullKeyboardAccessEnabled = false
    @State private var showingKeyboardAccessOffAlert = false
    @State private var increaseSizeEnabled = false
    @State private var highContrastEnabled = false
    let table = "FullKeyboardAccessSettings"
    let accTable = "Accessibility"
    let axTable = "AXUILocalizedStrings"
    
    var body: some View {
        CustomList(title: "FULL_KEYBOARD_ACCESS".localize(table: table)) {
            Section {
                Toggle("FULL_KEYBOARD_ACCESS".localize(table: table), isOn: $fullKeyboardAccessEnabled)
                    .alert("TURN_OFF_SC_ALERT_TITLE".localize(table: axTable), isPresented: $showingKeyboardAccessOffAlert) {
                        Button("TURN_OFF_SC_ALERT_CONFIRM".localize(table: axTable)) {}
                        Button("TURN_OFF_SC_ALERT_CANCEL".localize(table: axTable), role: .cancel) { fullKeyboardAccessEnabled = true }
                    } message: {
                        Text("TURN_OFF_FKA_ALERT_MESSAGE", tableName: axTable)
                    }
                    .onChange(of: fullKeyboardAccessEnabled) {
                        showingKeyboardAccessOffAlert = !fullKeyboardAccessEnabled
                    }
            } footer: {
                Text("""
                    **\("FULL_KEYBOARD_ACCESS_FOOTER_IPHONE".localize(table: table))**
                    \("HELP_INSTRUCTION".localize(table: table, "Tab H"))
                    \("MOVE_FORWARD_INSTRUCTION".localize(table: table, "Tab"))
                    \("MOVE_BACKWARD_INSTRUCTION".localize(table: table, "\u{21E7} Tab"))
                    \("ACTIVATE_ITEM_INSTRUCTION".localize(table: table, "Space"))
                    \("HOME_INSTRUCTION".localize(table: table, "Fn H"))
                    \("CONTROL_CENTER_INSTRUCTION".localize(table: table, "Fn C"))
                    \("NOTIFICATION_CENTER_INSTRUCTION".localize(table: table, "Fn N"))
                    """)
            }
            
            Section {
                NavigationLink("COMMANDS".localize(table: table), destination: FullKeyboardAccessView())
            }
            
            Section {
                CustomNavigationLink("FOCUS_RING_TIMEOUT".localize(table: table), status: "15s", destination: AutoHideView())
                Toggle("FOCUS_RING_LARGE_FOCUS_RING".localize(table: table), isOn: $increaseSizeEnabled)
                Toggle("FOCUS_RING_FOCUS_RING_HIGH_CONTRAST".localize(table: table), isOn: $highContrastEnabled)
                CustomNavigationLink("FOCUS_RING_COLOR".localize(table: table), status: "DEFAULT".localize(table: accTable), destination: KeyboardColorView())
            } header: {
                Text("APPEARANCE", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        FullKeyboardAccessView()
    }
}
