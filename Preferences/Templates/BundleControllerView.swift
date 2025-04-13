/*
Abstract:
A view that implements a UIViewControllerRepresentable instance with common modifiers.
*/

import SwiftUI

struct BundleControllerView: View {
    let bundle: String
    let controller: String
    var title: String = ""
    var table: String = ""
    
    init(_ bundle: String, controller: String, title: String = "", table: String = "") {
        self.bundle = bundle
        self.controller = controller
        self.title = title
        self.table = table
    }
    
    var body: some View {
        CustomViewController(bundle.contains("/") ? bundle : "/System/Library/PreferenceBundles/\(bundle).bundle/\(bundle)", controller: controller)
            .ignoresSafeArea()
            .navigationTitle(title.localize(table: table))
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        BundleControllerView("AccessibilitySettings", controller: "AXDisplayController", title: "DISPLAY_AND_TEXT", table: "Accessibility")
    }
}
