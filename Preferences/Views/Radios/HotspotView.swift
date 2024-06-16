//
//  HotspotView.swift
//  Preferences
//
//  Settings > Personal Hotspot
//

import SwiftUI

struct HotspotView: View {
    // Variables
    @State private var allowOthersJoinEnabled = false
    @State private var password = String()
    @State private var maximizeCompatibility = false
    
    var body: some View {
        CustomList(title: "Personal Hotspot") {
            SectionHelp(title: "Personal Hotspot", color: .green, icon: "personalhotspot", description: "Share your \(Device().model)'s internet connection with other devices. Personal Hotspot is useful when Wi-Fi isn't available. [Learn more...](https://support.apple.com/guide/iphone/share-your-internet-connection-iph45447ca6/ios)")
            
            Section {
                Toggle("Allow Others to Join", isOn: $allowOthersJoinEnabled)
                CustomNavigationLink(title: "Wi-Fi Password", status: password, destination: EmptyView())
                    .onAppear {
                        password = randomPassword()
                    }
            }
            
            Section {} footer: {
                Text("Allow other users or devices not signed into iCloud to look for your shared network \u{201C}\(Device().model)\u{201D} when you are in Personal Hotspot settings or when you turn it on in Control Center.")
            }
            
//            Section {
//                NavigationLink("Family Sharing", destination: EmptyView())
//            } footer: {
//                Text("Share Personal Hotspot with members of Family Sharing")
//            }
            
            Section {
                Toggle("Maximize Compatability", isOn: $maximizeCompatibility)
            } footer: {
                Text("Internet performance may be reduced for devices connected to your hotspot when turned on.")
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
