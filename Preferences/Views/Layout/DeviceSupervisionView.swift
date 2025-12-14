//
//  DeviceSupervisionView.swift
//  Preferences
//

import SwiftUI
import WebKit

/// Basic WebView container based on PSAboutHTMLSheetViewController (Preferences)
/// for displaying Device Supervision information.
struct DeviceSupervisionView: View {
    @Environment(\.dismiss) private var dismiss
    private var text: String {
        "DEVICE_SUPERVISION_INFO".localized(
            path: "/System/Library/PrivateFrameworks/Preferences.framework",
            table: "DeviceSupervisionInfo"
        )
    }
    
    var body: some View {
        NavigationStack {
            WebView(url: URL(string: "data:text/html,\(formatHTML(fragment: text))"))
                .navigationTitle("Device Supervision")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(.done) {
                            dismiss()
                        }
                    }
                }
        }
    }
    
    private func formatHTML(fragment: String) -> String {
        let languageID = Locale.preferredLanguages.first ?? "en"
        let direction = Locale.Language(identifier: languageID).characterDirection == .rightToLeft
            ? "; direction: rtl"
            : ""

        return """
        <html>
          <head>
            <meta charset="utf-8">
            <meta name="viewport"
                  content="width=device-width,
                           initial-scale=1,
                           maximum-scale=1,
                           user-scalable=no"/>
            <style type="text/css">
              :root { supported-color-schemes: light dark }
              body {
                font: -apple-system-body;
                word-wrap: break-word;
                -khtml-nbsp-mode: space;
                -khtml-line-break: after-white-space;
                color: -apple-system-label;
                background-color: -apple-system-background\(direction);
              }
            </style>
          </head>
          <body>
            \(fragment)
          </body>
        </html>
        """
    }
}

#Preview {
    NavigationStack {
        DeviceSupervisionView()
    }
}
