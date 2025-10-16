//
//  PrepareFollowUpView.swift
//  Preferences
//
//  Settings
//

import SwiftUI

/// Persistent take-action section in Settings to help a user prepare for a new device.
///
/// - Important: The associated asset is not available in simulator images.
struct PrepareFollowUpView: View {
    var body: some View {
        Section {
            HStack {
                if let asset = UIImage.asset(path: "/System/Library/PrivateFrameworks/MobileBackup.framework/PlugIns/MBPrebuddyFollowUpExtension.appex", name: "iPhone") {
                    Image(uiImage: asset)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 42)
                        .foregroundStyle(.blue)
                }
                LabeledContent {} label: {
                    Text("Get Ready For Your New iPhone")
                    Text("Use iCloud to move your apps and data to your new iPhone.")
                }
            }
            Button("Get Started") {}.foregroundStyle(.blue)
        }
    }
}

#Preview {
    PrepareFollowUpView()
}
