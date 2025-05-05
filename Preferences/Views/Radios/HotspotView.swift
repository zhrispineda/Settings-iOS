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
    @State private var password = ""
    
    var body: some View {
        CustomList {
            Placard(title: "Personal Hotspot", color: .green, icon: "personalhotspot", description: "Personal Hotspot allows you to share a cellular internet connection from your \(UIDevice.current.model) to other nearby devices. [Learn more…](https://support.apple.com/guide/iphone/share-your-internet-connection-iph45447ca6/ios)", frameY: $frameY, opacity: $opacity)
            
            Section {
                Toggle("Allow Others to Join", isOn: $allowOthersJoinEnabled)
                CustomNavigationLink("Wi-Fi Password", status: password, destination: EmptyView())
                    .onAppear {
                        password = randomPassword()
                    }
            }
            
            Section {} footer: {
                Text("Allow other users or devices not signed into iCloud to look for your shared network “\(deviceName)” when you are in Personal Hotspot settings or when you turn it on in Control Center.")
            }
            
            Section {
                Toggle("Maximize Compatability", isOn: $maximizeCompatibility)
            } footer: {
                Text("Internet performance may be reduced for devices connected to your hotspot when turned on.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("**Personal Hotspot**")
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
    
    func randomPassword() -> String {
        let letters = "abcdefghjkmnopqrstuvwxyz"
        var random = SystemRandomNumberGenerator()
        var randomString = ""
        for i in 0..<20 {
            let randomIndex = Int(random.next(upperBound: UInt32(letters.count)))
            if i == 6 || i == 13 {
                let randomCharacter = "-"
                randomString.append(randomCharacter)
            } else {
                let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
                randomString.append(randomCharacter)
            }
        }
        return randomString
    }
}

#Preview {
    NavigationStack {
        HotspotView()
    }
}
