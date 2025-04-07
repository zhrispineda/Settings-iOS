//
//  LargerTextView.swift
//  Preferences
//
//  Settings > Display & Brightness > Text Size
//  Settings > Accessibility > Display & Text Size > Larger Text View
//

import SwiftUI

struct LargerTextView: View {
    @State private var largerAccessibilitySizes = false
    let table = "Accessibility"
    let fontTable = "LargeFontsSettings"
    let displayTable = "Display"
    var textOnly = false
    
    var body: some View {
        if textOnly {
            ZStack {
                GeometryReader { geometry in
                    CustomList(title: textOnly ? "TEXT_SIZE".localize(table: table) : "LARGER_TEXT".localize(table: table)) {
                        if !textOnly {
                            Section {
                                Toggle("LARGER_DYNAMIC_TYPE".localize(table: table), isOn: $largerAccessibilitySizes)
                            }
                        }
                        if UIDevice.iPhone {
                            Text("DYNAMIC_TYPE_DESCRIPTION", tableName: fontTable)
                                .multilineTextAlignment(.center)
                                .offset(y: -5)
                                .listRowBackground(Color.clear)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .overlay {
                        VStack {
                            Spacer(minLength: UIDevice.iPhone ? geometry.size.height/1.2 : geometry.size.height/2.5)
                            CustomViewController(path: "/System/Library/PrivateFrameworks/Settings/DisplayAndBrightnessSettings.framework/DisplayAndBrightnessSettings", controller: "DBSLargeTextSliderListController")
                        }
                    }
                }
            }
        } else {
            CustomViewController(path: "/System/Library/PreferenceBundles/AccessibilitySettings.bundle/AccessibilitySettings", controller: "LiveCaptionsTextViewController")
                .ignoresSafeArea()
                .navigationTitle("LARGER_TEXT".localize(table: table))
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        LargerTextView()
    }
}
