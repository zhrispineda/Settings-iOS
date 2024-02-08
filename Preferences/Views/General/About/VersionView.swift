//
//  VersionView.swift
//  Preferences
//
//  Settings > General > About [iOS/iPadOS] Version
//

import SwiftUI

struct VersionView: View {
    var body: some View {
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
    }
}

#Preview {
    NavigationStack {
        VersionView()
    }
}
