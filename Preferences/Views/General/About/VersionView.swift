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
                Section(content: {
                    VStack(alignment: .leading) {
                        Text("**\(UIDevice().systemName) \(UIDevice().systemVersion) (21E5195d)**")
                        Text("This update includes improvements and bug fixes for your \(UIDevice().localizedModel).")
                            .foregroundStyle(.secondary)
                    }
                }, header: {
                    Text("\(UIDevice().systemName) Version")
                })
            }
            .navigationTitle("\(UIDevice().systemName) Version")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, DeviceInfo().isPhone ? 0 : (UIDevice.current.orientation.isLandscape ? 35 : 0))
        }
    }
}

#Preview {
    NavigationStack {
        VersionView()
    }
}
