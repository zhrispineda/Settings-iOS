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
    
    var body: some View {
        CustomList(title: "Display & Text Size") {
            Section {
                Toggle("Bold Text", isOn: $boldTextEnabled)
                CustomNavigationLink(title: "Larger Text", status: "Off", destination: LargerTextView())
                Toggle("Button Shapes", isOn: $buttonShapesEnabled)
                Toggle("On/Off Labels", isOn: $onOffLabelsEnabled)
            }
            
            Section {
                Toggle("Reduce Transparency", isOn: $reduceTransparencyEnabled)
            } footer: {
                Text("Improve contrast by reducing transparency and blurs on some backgrounds to increase legibility.")
            }
            
            Section {
                Toggle("Increase Contrast", isOn: $increaseContrastEnabled)
            } footer: {
                Text("Increase color contrast between app foreground and background colors.")
            }
            
            Section {
                Toggle("Differentiate Without Color", isOn: $differentiateWithoutColorEnabled)
            } footer: {
                Text("Replaces user interface items that rely solely on color to convey information with alternatives.")
            }
            
            Section {
                Toggle("Prefer Horizontal Text", isOn: $preferHorizontalTextEnabled)
            } footer: {
                Text("Prefer horizontal text in languages that support vertical text.")
            }
            
            Section {
                Toggle("Smart Invert", isOn: $smartInvertEnabled)
            } footer: {
                Text("Smart Invert reverses the colors of the display, except for images, media and some apps that use dark color styles.")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DisplayTextSizeView()
    }
}
