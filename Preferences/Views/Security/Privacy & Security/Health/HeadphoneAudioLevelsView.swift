//
//  HeadphoneAudioLevelsView.swift
//  NanoSettings
//

import SwiftUI

/// Settings > Privacy & Security > Health > Headphone Audio Levels
struct HeadphoneAudioLevelsView: View {
    private let path = "/System/Library/PreferenceBundles/Privacy/HealthPrivacySettings.bundle"
    
    var body: some View {
        BundleControllerView(
            "\(path)/HealthPrivacySettings",
            controller: "HKHealthPrivacyHeadphoneLevelsViewController",
            title: "HEADPHONE_AUDIO_LEVELS".localized(path: path)
        )
    }
}

#Preview {
    NavigationStack {
        HeadphoneAudioLevelsView()
    }
}
