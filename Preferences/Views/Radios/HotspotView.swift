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
            }
            
            Section {} footer: {
                Text("TETHERING_TEXT_DEFAULT".localized(path: path, table: table, deviceName))
            }
            
            // Maximize Compatibility
            Section {
                Toggle("MAXIMIZE_COMPATIBILITY".localized(path: path, table: table), isOn: $maximizeCompatibility)
            } footer: {
                Text("MAXIMIZE_COMPATIBILITY_FOOTER".localized(path: path, table: table))
            }
            
            // To connect using [Wi-Fi/Bluetooth/USB]
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top) {
                    Image(systemName: "wifi")
                        .font(.title)
                        .frame(width: 50)
                    Text("""
                        \("CONNECT_OVER_WIFI_LABEL".localized(path: path, table: table, "WIFI"))
                        \("STEP_1".localized(path: path, table: table)) \("CONNECT_OVER_WIFI_STEP_1".localized(path: path, table: table, deviceName, "WIFI"))
                        \("STEP_2".localized(path: path, table: table)) \("CONNECT_OVER_WIFI_STEP_2".localized(path: path, table: table, "WIFI"))
                        """)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                HStack(alignment: .top) {
                    Image(_internalSystemName: "bluetooth")
                        .font(.title)
                        .frame(width: 50)
                    Text("""
                        \("CONNECT_OVER_BLUETOOTH_LABEL".localized(path: path, table: table))
                        \("STEP_1".localized(path: path, table: table)) \("\(UIDevice.iPhone ? "CONNECT_OVER_BLUETOOTH_STEP_1_IPHONE" : "CONNECT_OVER_BLUETOOTH_STEP_1_IPAD")".localized(path: path, table: table))
                        \("STEP_2".localized(path: path, table: table)) \("\(UIDevice.iPhone ? "CONNECT_OVER_BLUETOOTH_STEP_2_IPHONE" : "CONNECT_OVER_BLUETOOTH_STEP_2_IPAD")".localized(path: path, table: table))
                        \("STEP_3".localized(path: path, table: table)) \("\(UIDevice.iPhone ? "CONNECT_OVER_BLUETOOTH_STEP_3_IPHONE" : "CONNECT_OVER_BLUETOOTH_STEP_3_IPAD")".localized(path: path, table: table))
                        """)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                HStack(alignment: .top) {
                    Image(_internalSystemName: "usb")
                        .font(.title)
                        .frame(width: 50)
                    Text("""
                        \("CONNECT_OVER_USB_LABEL".localized(path: path, table: table))
                        \("STEP_1".localized(path: path, table: table)) \("\(UIDevice.iPhone ? "CONNECT_OVER_USB_STEP_1_IPHONE" : "CONNECT_OVER_USB_STEP_1_IPAD")".localized(path: path, table: table))
                        \("STEP_2".localized(path: path, table: table)) \("\(UIDevice.iPhone ? "CONNECT_OVER_USB_STEP_2_IPHONE" : "CONNECT_OVER_USB_STEP_2_IPAD")".localized(path: path, table: table))
                        """)
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.clear)
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
