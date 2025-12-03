//
//  SafetyCheckView.swift
//  Preferences
//
//  Settings > Privacy & Security > Safety Check
//

import SwiftUI

struct SafetyCheckView: View {
    let path = "/System/Library/PreferenceBundles/DigitalSeparationSettings.bundle"
    
    var body: some View {
        BundleControllerView(
            "DigitalSeparationSettings",
            controller: "DSSafetyCheckWelcomeController",
            title: "SAFETY_CHECK".localized(path: path)
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("QUICK_EXIT".localized(path: path)) {
                    prepareQuickExit()
                }
            }
        }
    }
    
    private func prepareQuickExit() {
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let root = scene.windows.first?.rootViewController
        else { return }

        quickExit(in: root)
    }

    private func quickExit(in vc: UIViewController) {
        if vc.responds(to: Selector(("quickExit"))) {
            vc.perform(Selector(("quickExit")))
        }

        for child in vc.children {
            quickExit(in: child)
        }
    }
}

#Preview {
    NavigationStack {
        SafetyCheckView()
    }
}
