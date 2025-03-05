//
//  DisplayTextSizeView.swift
//  Preferences
//
//  Settings > Accessibility > Display & Text Size
//

import SwiftUI

struct DisplayTextSizeView: View {
    // Variables
    @State private var boldTextEnabled = false
    @State private var buttonShapesEnabled = false
    @State private var onOffLabelsEnabled = false
    @State private var reduceTransparencyEnabled = false
    @State private var increaseContrastEnabled = false
    @State private var differentiateWithoutColorEnabled = false
    @State private var preferHorizontalTextEnabled = false
    @State private var smartInvertEnabled = false
    let table = "Accessibility"
    
    var body: some View {
        CustomList(title: "DISPLAY_AND_TEXT".localize(table: table)) {
            Section {
                Toggle("ENHANCE_TEXT_LEGIBILITY".localize(table: table), isOn: $boldTextEnabled)
                CustomNavigationLink("LARGER_TEXT".localize(table: table), status: "OFF".localize(table: table), destination: LargerTextView())
                Toggle("BUTTON_SHAPES".localize(table: table), isOn: $buttonShapesEnabled)
                Toggle("ON_OFF_LABELS".localize(table: table), isOn: $onOffLabelsEnabled)
            }
            
            Section {
                Toggle("ENHANCE_BACKGROUND_CONTRAST".localize(table: table), isOn: $reduceTransparencyEnabled)
            } footer: {
                Text("ReduceTransparencyFooterText", tableName: table)
            }
            
            Section {
                Toggle("TEXT_COLORS_DARKEN".localize(table: table), isOn: $increaseContrastEnabled)
            } footer: {
                Text("TEXT_COLORS_DARKEN_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("DIFFERENTIATE_WITHOUT_COLOR".localize(table: table), isOn: $differentiateWithoutColorEnabled)
            } footer: {
                Text("DIFFERENTIATE_WITHOUT_COLOR_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("PREFER_HORIZONTAL_TEXT".localize(table: table), isOn: $preferHorizontalTextEnabled)
            } footer: {
                Text("PREFER_HORIZONTAL_TEXT_FOOTER", tableName: table)
            }
            
            Section {
                Toggle("SMART_INVERT".localize(table: table), isOn: $smartInvertEnabled)
            } footer: {
                Text("SmartInvertColorsFooter", tableName: table)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DisplayTextSizeView()
    }
}
