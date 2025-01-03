//
//  VersionView.swift
//  Preferences
//
//  Settings > General > About [iOS/iPadOS] Version
//

import SwiftUI
import os

struct VersionView: View {
    // Variables
    let table = "GeneralSettingsUI"
    
    var body: some View {
        CustomList(title: "\(UIDevice().systemName) Version", topPadding: true) {
            Section("OS Version".localize(table: table)) {
                VStack(alignment: .leading) {
                    Text("\(UIDevice().systemName) \(UIDevice().systemVersion) (\(getVersionBuild()))")
                        .fontWeight(.bold)
                    if getReleaseType() == "Beta" {
                        Text("\(UIDevice().systemName) beta gives you an early preview of upcoming apps, features, and technologies. Please back up your \(UIDevice.current.model) before you install the beta.\n")
                            .font(.callout)
                        Text("""
                            For more information, please visit one of the following programs:
                            \u{2022} Apple Beta Software Program at [beta.apple.com](beta.apple.com)
                            \u{2022} Apple Developer Program at [developer.apple.com](developer.apple.com)
                            """)
                        .font(.callout)
                    } else {
                        Text("SW_DETAIL_OS".localize(table: "General", UIDevice.current.model))
                            .textSelection(.enabled)
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    }
                }
            }
        }
    }
    
    // Functions
    private func getReleaseType() -> String {
        guard let mobileGestalt = UIDevice.checkDevice(),
              let cacheExtra = mobileGestalt["CacheExtra"] as? [String: AnyObject],
              let releaseType = cacheExtra["9UCjT7Qfi4xLVvPAKIzTCQ"] as? String else { // ReleaseType key
            return "Release" // Fallback
        }
        return releaseType
    }
    
    private func getVersionBuild() -> String {
        guard let mobileGestalt = UIDevice.checkDevice(),
              let cacheExtra = mobileGestalt["CacheExtra"] as? [String: AnyObject],
              let buildVersion = cacheExtra["mZfUC7qo4pURNhyMHZ62RQ"] as? String else { // BuildVersion key
            return "22C152" // Fallback
        }
        return buildVersion
    }
}

#Preview {
    NavigationStack {
        VersionView()
    }
}
