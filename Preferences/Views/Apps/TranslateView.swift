//
//  TranslateView.swift
//  Preferences
//
//  Settings > Apps > Translate
//

import SwiftUI

struct TranslateView: View {
    private let path = "/System/Library/PrivateFrameworks/TranslationUI.framework"
    
    var body: some View {
        ControllerBridgeView(
            "\(path)/TranslationUI",
            controller: "LTUITranslateSettingsController",
            title: "TRANSLATE".localized(path: path)
        )
    }
}

#Preview {
    NavigationStack {
        TranslateView()
    }
}
