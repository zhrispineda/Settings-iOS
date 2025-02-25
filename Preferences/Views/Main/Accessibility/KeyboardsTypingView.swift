//
//  KeyboardsTypingView.swift
//  Preferences
//
//  Settings > Accessibility > Keyboards & Typing
//

import SwiftUI

struct KeyboardsTypingView: View {
    // Variables
    @State private var showLowercaseKeysEnabled = true
    let table = "KeyboardsSettings"
    let accTable = "Accessibility"
    let keyTable = "FullKeyboardAccessSettings"
    
    var body: some View {
        CustomList(title: "KEYBOARDS".localize(table: table), topPadding: true) {
            Section {
                CustomNavigationLink(title: "HOVER_TYPING".localize(table: table), status: "OFF".localize(table: accTable), destination: HoverTextView())
            } footer: {
                Text("HOVER_TYPING_FOOTER", tableName: accTable)
            }
            
            Section {
                NavigationLink("TYPING_FEEDBACK".localize(table: table), destination: EmptyView())
            }
            
            Section {
                CustomNavigationLink(title: "FULL_KEYBOARD_ACCESS".localize(table: keyTable), status: "OFF".localize(table: accTable), destination: FullKeyboardAccessView())
            } header: {
                Text("HARDWARE_KEYBOARDS", tableName: table)
            } footer: {
                if UIDevice.iPhone {
                    Text("FULL_KEYBOARD_ACCESS_FOOTER_IPHONE", tableName: keyTable)
                } else if UIDevice.iPad {
                    Text("FULL_KEYBOARD_ACCESS_FOOTER_IPAD", tableName: keyTable)
                }
            }
            
            Section {
                CustomNavigationLink(title: "KEY_REPEAT".localize(table: table), status: "ON".localize(table: accTable), destination: KeyRepeatView())
                CustomNavigationLink(title: "STICKY_KEYS".localize(table: table), status: "OFF".localize(table: accTable), destination: StickyKeysView())
                CustomNavigationLink(title: "SLOW_KEYS".localize(table: table), status: "OFF".localize(table: accTable), destination: SlowKeysView())
            } footer: {
                Text("HARDWARE_KEYBOARDS_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("LOWERCASE_KEYBOARD".localize(table: table), isOn: $showLowercaseKeysEnabled)
            } header: {
                Text("SOFTWARE_KEYBOARDS", tableName: table)
            } footer: {
                Text("LOWERCASE_KEYBOARD_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        KeyboardsTypingView()
    }
}
