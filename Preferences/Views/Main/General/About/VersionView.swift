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
                        Text("**\(UIDevice().systemName) \(UIDevice().systemVersion) (22A5282m)**")
                        if Configuration().isSimulator {
                            Text("This update includes improvements and bug fixes for your \(Device().model).")
                                .foregroundStyle(.secondary)
                                .font(.callout)
                        } else {
                            Text("This update includes improvements and bug fixes for your \(Device().model).")
                                .foregroundStyle(.secondary)
                                .font(.callout)
//                            Text("This update introduces new emoji, transcripts in Apple Podcasts and includes other features, bug fixes, and and security updates for your \(Device().model).\n")
//                                .font(.callout)
//                            Text("For more information on the security content of Apple software updates, please visit this website:\n https://support.apple.com/kb/HT201222\n")
//                                .font(.callout)
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
