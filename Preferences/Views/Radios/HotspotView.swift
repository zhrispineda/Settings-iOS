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
            Section {
                EmptyView()
            } footer: {
                Text("Personal Hotspot on your iPhone can provide Internet access to other devices signed into your iCloud account without requiring you to enter the password.")
            }
            
            Section {
                Toggle("Allow Others to Join", isOn: $allowOthersJoinEnabled)
                CustomNavigationLink(title: "Wi-Fi Password", status: password, destination: EmptyView())
                    .onAppear(perform: {
                        password = randomPassword()
                    })
            }
            
            Section {
                EmptyView()
            } footer: {
                Text("Allow other users or devices not signed into iCloud to look for your shared network \u{201C}\(UIDevice().localizedModel)\u{201D} when you are in Personal Hotspot settings or when you turn it on in Control Center.")
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
