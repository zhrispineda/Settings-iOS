//
//  DisplayTextSizeView.swift
//  Preferences
//
//  Settings > Accessibility > Display & Text Size
//

import SwiftUI

struct DisplayTextSizeView: View {
    var body: some View {
        CustomViewController(path: "/System/Library/PreferenceBundles/AccessibilitySettings.bundle/AccessibilitySettings", controller: "AXDisplayController")
            .ignoresSafeArea()
            .navigationTitle("DISPLAY_AND_TEXT".localize(table: "Accessibility"))
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DisplayTextSizeView()
    }
}
