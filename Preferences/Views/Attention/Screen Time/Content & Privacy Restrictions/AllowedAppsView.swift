//
//  AllowedAppsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Allowed Apps
//

import SwiftUI

struct AllowedAppsView: View {
    // Variables
    @State private var mailEnabled = true
    @State private var safariEnabled = true
    @State private var sharePlayEnabled = true
    @State private var siriEnabled = true
    @State private var walletEnabled = true
    @State private var airDropEnabled = true
    @State private var carPlayEnabled = true
    @State private var newsEnabled = true
    @State private var healthEnabled = true
    @State private var fitnessEnabled = true
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AllowedAppsSpecifierName".localize(table: table)) {
            Section {
                IconToggle("Mail", isOn: $mailEnabled, icon: "com.apple.mobilemail")
                IconToggle("Safari", isOn: $safariEnabled, icon: "com.apple.Safari")
                IconToggle("SharePlaySpecifierName", isOn: $sharePlayEnabled, icon: "com.apple.graphic-icon.shareplay", table: table)
                IconToggle("SiriDictationSpecifierName", isOn: $siriEnabled, icon: "com.apple.application-icon.siri", table: table)
                IconToggle("Wallet", isOn: $walletEnabled, icon: "com.apple.Passbook")
                IconToggle("AirDropSpecifierName", isOn: $airDropEnabled, icon: "com.apple.graphic-icon.airdrop", table: table)
                IconToggle("CarPlaySpecifierName", isOn: $carPlayEnabled, icon: "com.apple.graphic-icon.carplay", table: table)
            }
            
            Section {
                IconToggle("News", isOn: $newsEnabled, icon: "com.apple.news")
                IconToggle("Health", isOn: $healthEnabled, icon: "com.apple.Health")
                IconToggle("Fitness", isOn: $fitnessEnabled, icon: "com.apple.Fitness")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AllowedAppsView()
    }
}
