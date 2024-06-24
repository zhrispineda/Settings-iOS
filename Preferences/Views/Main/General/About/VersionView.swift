//
//  VersionView.swift
//  Preferences
//
//  Settings > General > About [iOS/iPadOS] Version
//

import SwiftUI

struct VersionView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            List {
                Section {
                    VStack(alignment: .leading) {
                        Text("**\(UIDevice().systemName) \(UIDevice().systemVersion) (22A5297f)**")
                        if Configuration().isSimulator {
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
                    
                    if !Configuration().isSimulator {
//                        Button {} label: {
//                            Text("Learn More")
//                        }
                    }
                } header: {
                    Text("\(UIDevice().systemName) Version")
                }
            }
            .navigationTitle("\(UIDevice().systemName) Version")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, Device().isPhone ? 0 : (UIDevice.current.orientation.isLandscape ? 35 : 0))
        }
    }
}

#Preview {
    NavigationStack {
        VersionView()
    }
}
