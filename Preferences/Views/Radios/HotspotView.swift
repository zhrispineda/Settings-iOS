//
//  HotspotView.swift
//  Preferences
//
//  Settings > Personal Hotspot
//

import SwiftUI

struct HotspotView: View {
    @AppStorage("DeviceName") private var deviceName = UIDevice.current.model
    @State private var allowOthersJoinEnabled = false
    @State private var frameY = 0.0
    @State private var maximizeCompatibility = false
    @State private var opacity = 0.0
    @State private var showingHelpSheet = false
    @State private var password = ""
    let path = "/System/Library/PreferenceBundles/WirelessModemSettings.bundle"
    let table = "WirelessModemSettings"
    
    var body: some View {
        CustomList {
            Placard(title: "MAIN_SPEC_PROVISIONED".localized(path: path, table: table), icon: "com.apple.graphic-icon.personal-hotspot", description: "PLACARD_SUBTITLE".localized(path: path, table: table).replacing("helpkit", with: "pref"), frameY: $frameY, opacity: $opacity)
            
            // Allow Others to Join
            // Wi-Fi Password
            Section {
                Toggle("ALLOW_OTHERS".localized(path: path, table: table), isOn: $allowOthersJoinEnabled)
                SettingsLink("WIFI_PASSWORD".localized(path: path, table: table, "WIFI"), status: password, destination: EmptyView())
                    .onAppear {
                        password = randomPassword()
                    }
            } footer: {
                Text("TETHERING_TEXT_DEFAULT".localized(path: path, table: table, deviceName))
            }
            
            // Maximize Compatibility
            Section {
                Toggle("MAXIMIZE_COMPATIBILITY".localized(path: path, table: table), isOn: $maximizeCompatibility)
            } footer: {
                Text("MAXIMIZE_COMPATIBILITY_FOOTER".localized(path: path, table: table))
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MAIN_SPEC_PROVISIONED".localized(path: path, table: table))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
        .onOpenURL {_ in
            showingHelpSheet.toggle()
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph45447ca6" : "ipadb2c87b68")
                .ignoresSafeArea(edges: .bottom)
                .interactiveDismissDisabled()
        }
    }
    
    func randomPassword(length: Int = 20, separatorIndices: Set<Int> = [6, 13]) -> String {
        let letters = Array("abcdefghjkmnopqrstuvwxyz")
        var password = ""

        for i in 0..<length {
            if separatorIndices.contains(i) {
                password.append("-")
            } else if let randomChar = letters.randomElement() {
                password.append(randomChar)
            }
        }

        return password
    }
}

#Preview {
    NavigationStack {
        HotspotView()
    }
}
