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
    @State private var fitnessEnabled = true
    let table = "Restrictions"
    
    var body: some View {
        CustomList(title: "AllowedAppsSpecifierName".localize(table: table)) {
            Section {
                IconToggle(enabled: $safariEnabled, icon: "appleSafari", title: "Safari")
                IconToggle(enabled: $sharePlayEnabled, color: .green, icon: "shareplay", title: "SharePlaySpecifierName".localize(table: table))
                IconToggle(enabled: $siriEnabled, icon: "appleSiri", title: "SiriDictationSpecifierName".localize(table: table))
                IconToggle(enabled: $walletEnabled, icon: "appleWallet", title: "Wallet")
                IconToggle(enabled: $airDropEnabled, color: .white, icon: "airdrop", title: "AirDropSpecifierName".localize(table: table))
                IconToggle(enabled: $carPlayEnabled, color: .green, icon: "appleCarPlay", title: "CarPlaySpecifierName".localize(table: table))
            }
            
            Section {
                IconToggle(enabled: $newsEnabled, icon: "appleNews", title: "News")
                IconToggle(enabled: $healthEnabled, icon: "appleHealth", title: "Health")
                IconToggle(enabled: $fitnessEnabled, icon: "appleFitness", title: "Fitness")
            }
        }
    }
}

#Preview {
    NavigationStack {
        AllowedAppsView()
    }
}
