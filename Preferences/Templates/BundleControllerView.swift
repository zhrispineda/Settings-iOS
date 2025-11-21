/*
Abstract:
A view that implements a UIViewControllerRepresentable instance with common modifiers.
*/

import SwiftUI

struct BundleControllerView: View {
    let bundle: String
    let controller: String
    var title: String = ""
    var path: String = ""
    var table: String = ""
    
    init(_ bundle: String, controller: String, title: String = "", path: String = "", table: String = "") {
        self.bundle = bundle
        self.controller = controller
        self.title = title
        self.path = path
        self.table = table
    }
    
    var body: some View {
        CustomViewController(bundle.contains("/") ? bundle : "/System/Library/PreferenceBundles/\(bundle).bundle/\(bundle)", controller: controller)
            .ignoresSafeArea()
            .navigationTitle(path.isEmpty ? title.localize(table: table) : title.localized(path: path, table: table))
            .navigationBarTitleDisplayMode(.inline)
            .border(PrimarySettingsListModel.shared.showingDebugOverlays ? Color.green.opacity(0.5) : .clear)
            .overlay(alignment: .topLeading) {
                if PrimarySettingsListModel.shared.showingDebugOverlays {
                    Text(controller)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(Color.green.colorMultiply(.gray))
                        .cornerRadius(0)
                        .offset(x: 1, y: 1)
                }
            }
    }
}

#Preview {
    NavigationStack {
        BundleControllerView("AccessibilitySettings", controller: "AXDisplayController", title: "DISPLAY_AND_TEXT", table: "Accessibility")
    }
}
