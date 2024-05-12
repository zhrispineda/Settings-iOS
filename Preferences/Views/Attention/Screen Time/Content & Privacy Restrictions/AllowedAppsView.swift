//
//  AllowedAppsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Allowed Apps
//

import SwiftUI

struct AllowedAppsView: View {
    // Variables
    @State private var safariEnabled = true
    @State private var sharePlayEnabled = true
    @State private var siriEnabled = true
    @State private var walletEnabled = true
    @State private var airDropEnabled = true
    @State private var carPlayEnabled = true
    @State private var newsEnabled = true
    @State private var healthEnabled = true
    
    var body: some View {
        CustomList(title: "Allowed Apps") {
            Section {
                IconToggle(enabled: $safariEnabled, icon: "applesafari", title: "Safari")
                IconToggle(enabled: $sharePlayEnabled, color: .green, icon: "shareplay", title: "SharePlay")
                IconToggle(enabled: $siriEnabled, icon: "applesiri", title: "Siri & Dictation")
                IconToggle(enabled: $walletEnabled, icon: "applewallet", title: "Wallet")
                Toggle("AirDrop", isOn: $airDropEnabled)
                IconToggle(enabled: $carPlayEnabled, color: .green, icon: "applecarplay", title: "CarPlay")
            }
            
            Section {
                IconToggle(enabled: $newsEnabled, icon: "applenews", title: "News")
                IconToggle(enabled: $healthEnabled, icon: "applehealth", title: "Health")
            }
        }
    }
}

#Preview {
    AllowedAppsView()
}
