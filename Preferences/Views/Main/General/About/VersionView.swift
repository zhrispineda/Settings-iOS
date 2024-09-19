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
    let logger = Logger()
    
    var body: some View {
        CustomList(title: "\(UIDevice().systemName) Version") {
            Section {
                VStack(alignment: .leading) {
                    Text("**\(UIDevice().systemName) \(UIDevice().systemVersion) (\(getVersionBuild()))**")
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
                        Text("This update includes improvements and bug fixes for your \(UIDevice.current.model).")
                            .textSelection(.enabled)
                            .foregroundStyle(.secondary)
                            .font(.callout)
                    }
                }
            } header: {
                Text("\n\(UIDevice().systemName) Version")
            }
        }
    }
    
    func getReleaseType() -> String {
        guard let mobileGestalt = UIDevice.checkDevice(),
              let cacheExtra = mobileGestalt["CacheExtra"] as? [String: AnyObject],
              let releaseType = cacheExtra["9UCjT7Qfi4xLVvPAKIzTCQ"] as? String else { // ReleaseType key
            logger.info("Key ReleaseType not found! Will fallback to Release.")
            return "Release" // Fallback
        }
        logger.info("Found key ReleaseType: \(releaseType)")
        return releaseType
    }
    
    func getVersionBuild() -> String {
        guard let mobileGestalt = UIDevice.checkDevice(),
              let cacheExtra = mobileGestalt["CacheExtra"] as? [String: AnyObject],
              let buildVersion = cacheExtra["mZfUC7qo4pURNhyMHZ62RQ"] as? String else { // BuildVersion key
            logger.info("Key BuildVersion not found! Will fallback to 22A3354.")
            return "22A3354" // Fallback
        }
        logger.info("Found key BuildVersion: \(buildVersion)")
        return buildVersion
    }
}

#Preview {
    NavigationStack {
        VersionView()
    }
}
