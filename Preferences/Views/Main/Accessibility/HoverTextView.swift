//
//  HoverTextView.swift
//  Preferences
//
//  Settings > Accessibility > Hover Text
//

import SwiftUI

struct HoverTextView: View {
    // Variables
    @State private var hoverTextEnabled = false
    @State private var textColor = Color.black
    @State private var insertionPointColor = Color.black
    @State private var backgroundColor = Color.black
    @State private var borderColor = Color.black
    @State private var activationLockEnabled = false
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "HOVER_TYPING".localize(table: table)) {
            Section {
                Toggle("HOVER_TYPING".localize(table: table), isOn: $hoverTextEnabled)
            } footer: {
                Text("HOVERTEXT_INTRO", tableName: table)
            }
            
            Section {
                CustomNavigationLink("AXHoverTextDisplayModeTitle".localize(table: table), status: "AXHoverTextDisplayModeDockedTopTitle".localize(table: table), destination: SelectOptionList(title: "AXHoverTextDisplayModeTitle", options: ["AXHoverTextDisplayModeInlineHoverTitle", "AXHoverTextDisplayModeDockedTopTitle", "AXHoverTextDisplayModeDockedBottomTitle"], selected: "AXHoverTextDisplayModeDockedTopTitle", table: table))
                CustomNavigationLink("AXHoverTextScrollingSpeedTitle".localize(table: table), status: "AXHoverTextScrollingSpeedDefaultTitle".localize(table: table), destination: SelectOptionList(title: "AXHoverTextScrollingSpeedTitle", options: ["AXHoverTextScrollingSpeedSlowestTitle", "AXHoverTextScrollingSpeedSlowerTitle", "AXHoverTextScrollingSpeedDefaultTitle", "AXHoverTextScrollingSpeedFasterTitle", "AXHoverTextScrollingSpeedFastestTitle"], selected: "AXHoverTextScrollingSpeedDefaultTitle", table: table))
                CustomNavigationLink("HOVER_TEXT_TEXT_STYLE".localize(table: table), status: "AXHoverTextScrollingSpeedDefaultTitle".localize(table: table), destination: HoverTextFontView())
                CustomNavigationLink("HOVER_TEXT_TEXT_SIZE".localize(table: table), status: "ON".localize(table: table), destination: HoverTextSizeView())
            } header: {
                Text("HOVER_TEXT_TEXT_OPTIONS", tableName: table)
            }
            
            Section {
                ColorPicker("HOVER_TEXT_TEXT_COLOR".localize(table: table), selection: $textColor)
                ColorPicker("HOVER_TEXT_INSERTION_POINT_COLOR".localize(table: table), selection: $insertionPointColor)
                ColorPicker("HOVER_TEXT_BACKGROUND_COLOR".localize(table: table), selection: $backgroundColor)
                ColorPicker("HOVER_TEXT_BORDER_COLOR".localize(table: table), selection: $borderColor)
            } header: {
                Text("HOVER_TEXT_COLOR_OPTIONS", tableName: table)
            }
            
            Section {
                CustomNavigationLink("HOVER_TEXT_ACTIVATION_MODIFIER".localize(table: table), status: "HOVER_TEXT_ACITVATOR_KEY_CONTROL".localize(table: table), destination: SelectOptionList(title: "HOVER_TEXT_ACTIVATION_MODIFIER", options: ["HOVER_TEXT_ACITVATOR_KEY_CONTROL", "HOVER_TEXT_ACITVATOR_KEY_OPTION", "HOVER_TEXT_ACITVATOR_KEY_COMMAND"], selected: "HOVER_TEXT_ACITVATOR_KEY_CONTROL", table: table))
                Toggle("HOVER_TEXT_ACTIVATION_LOCK".localize(table: table), isOn: $activationLockEnabled)
            } header: {
                Text("HOVER_TEXT_CONTROL_OPTIONS", tableName: table)
            } footer: {
                Text("HOVER_TEXT_CONTROL_OPTIONS_FOOTER", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HoverTextView()
    }
}
