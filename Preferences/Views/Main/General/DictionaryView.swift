//
//  DictionaryView.swift
//  Preferences
//
//  Settings > General > Dictionary
//

import SwiftUI

struct DictionaryView: View {
    let path = "/System/Library/PreferenceBundles/DictionarySettings.bundle"
    
    var body: some View {
        ControllerBridgeView(
            "\(path)/DictionarySettings",
            controller: "DictionarySettingsController",
            title: "Dictionary".localized(path: path, table: "DictionarySettings")
        )
    }
}

#Preview {
    DictionaryView()
}
