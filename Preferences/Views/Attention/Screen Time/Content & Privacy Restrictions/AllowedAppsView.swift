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
                IconToggle("Mail", isOn: $mailEnabled, icon: "appleMail")
                IconToggle("Safari", isOn: $safariEnabled, icon: "appleSafari")
                IconToggle("SharePlaySpecifierName", isOn: $sharePlayEnabled, color: .green, icon: "shareplay", table: table)
                IconToggle("SiriDictationSpecifierName", isOn: $siriEnabled, icon: "appleSiri", table: table)
                IconToggle("Wallet", isOn: $walletEnabled, icon: "appleWallet")
                IconToggle("AirDropSpecifierName", isOn: $airDropEnabled, color: .white, icon: "airdrop", table: table)
                IconToggle("CarPlaySpecifierName", isOn: $carPlayEnabled, color: .green, icon: "appleCarPlay", table: table)
            }
            
            Section {
                IconToggle("News", isOn: $newsEnabled, icon: "appleNews")
                IconToggle("Health", isOn: $healthEnabled, icon: "appleHealth")
                IconToggle("Fitness", isOn: $fitnessEnabled, icon: "appleFitness")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AllowedAppsView()
    }
}
