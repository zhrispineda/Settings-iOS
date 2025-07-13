//
//  AllowedAppsView.swift
//  Preferences
//
//  Settings > Screen Time > Content & Privacy Restrictions > Allowed Apps
//

import SwiftUI

struct AllowedAppsView: View {
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
    let path = "/System/Library/PrivateFrameworks/ScreenTimeSettingsUI.framework"
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AllowedAppsSpecifierName".localized(path: path, table: table)) {
            Section {
                IconToggle("Mail", isOn: $mailEnabled, icon: "com.apple.mobilemail")
                IconToggle("Safari", isOn: $safariEnabled, icon: "com.apple.mobilesafari")
                IconToggle("SharePlaySpecifierName".localized(path: path, table: table), isOn: $sharePlayEnabled, icon: "com.apple.graphic-icon.shareplay", table: table)
                IconToggle("SiriDictationSpecifierName".localized(path: path, table: table), isOn: $siriEnabled, icon: "com.apple.application-icon.siri", table: table)
                IconToggle("Wallet", isOn: $walletEnabled, icon: "com.apple.Passbook")
                IconToggle("AirDropSpecifierName".localized(path: path, table: table), isOn: $airDropEnabled, icon: "com.apple.graphic-icon.airdrop", table: table)
                IconToggle("CarPlaySpecifierName".localized(path: path, table: table), isOn: $carPlayEnabled, icon: "com.apple.graphic-icon.carplay", table: table)
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
