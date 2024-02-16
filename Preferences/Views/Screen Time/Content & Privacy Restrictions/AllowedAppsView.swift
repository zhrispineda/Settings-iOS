//
//  AllowedAppsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Allowed Apps
//

import SwiftUI

struct AllowedAppsView: View {
    // Variables
    @State private var airDropEnabled = true
    
    var body: some View {
        CustomList(title: "Allowed Apps") {
            Section {
                IconToggle(enabled: true, icon: "applesafari", title: "Safari")
                IconToggle(enabled: true, color: .green, icon: "shareplay", title: "SharePlay")
                IconToggle(enabled: true, icon: "applesiri", title: "Siri & Dictation")
                IconToggle(enabled: true, icon: "applewallet", title: "Wallet")
                Toggle("AirDrop", isOn: $airDropEnabled)
                IconToggle(enabled: true, color: .green, icon: "applecarplay", title: "CarPlay")
            }
            
            Section {
                IconToggle(enabled: true, icon: "applenews", title: "News")
                IconToggle(enabled: true, icon: "applehealth", title: "Health")
            }
        }
    }
}

#Preview {
    AllowedAppsView()
}
