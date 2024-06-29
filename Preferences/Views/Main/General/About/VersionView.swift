//
//  VersionView.swift
//  Preferences
//
//  Settings > General > About [iOS/iPadOS] Version
//

import SwiftUI

struct VersionView: View {
    var body: some View {
        CustomList(title: "\(UIDevice().systemName) Version") {
            Section {
                VStack(alignment: .leading) {
                    Text("**\(UIDevice().systemName) \(UIDevice().systemVersion) (22A5297f)**")
                    if UIDevice.isSimulator {
                        Text("This update includes improvements and bug fixes for your \(Device().model).")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    } else {
                        Text("\(UIDevice().systemName) beta gives you an early preview of upcoming apps, features, and technologies. Please back up your \(Device().model) before you install the beta.\n")
                            .font(.callout)
                        Text("""
                            For more information, please visit one of the following programs:
                            \u{2022} Apple Beta Software Program at [beta.apple.com](beta.apple.com)
                            \u{2022} Apple Developer Program at [developer.apple.com](developer.apple.com)
                            """)
                            .font(.callout)
                    }
                }
            } header: {
                Text("\n\(UIDevice().systemName) Version")
            }
        }
    }
}

#Preview {
    NavigationStack {
        VersionView()
    }
}
