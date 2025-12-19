//
//  PrepareFollowUpView.swift
//  Preferences
//

import SwiftUI

/// Follow Up item for Settings to help a user prepare for a new device.
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
            Button("Get Started") {}
        }
    }
}

/// Follow Up item for Settings to help a user sign out and erase their device.
struct NextForDeviceView: View {
    var body: some View {
        Section {
            Label {
                Text("What‘s next for this iPhone?")
                Text("Get step-by-step instructions to prepare this iPhone to be sold, given away, or traded in through Apple Trade In.")
            } icon: {
                if let asset = UIImage.asset(path: "/System/Library/PrivateFrameworks/Disembark.framework", name: "iphone") {
                    Image(uiImage: asset)
                }
            }
            
            Group {
                Button("Get Started") {}
                Button("Don‘t Erase iPhone") {}
            }
            .padding(.leading, 40)
        }
    }
}

#Preview {
    NavigationStack {
        List {
            PrepareFollowUpView()
            NextForDeviceView()
        }
    }
}
