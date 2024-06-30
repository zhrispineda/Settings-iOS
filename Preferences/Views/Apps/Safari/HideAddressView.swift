//
//  HideAddressView.swift
//  Preferences
//
//  Settings > Apps > Safari > Hide IP Address
//

import SwiftUI

struct HideAddressView: View {
    // Variables
    @State private var selected = "Off"
    let options = ["From Trackers", "Off"]
    
    var body: some View {
        CustomList(title: "Hide IP Address") {
            Section {
                Picker("", selection: $selected) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                .labelsHidden()
            } footer: {
                Text("Your IP address can be used to determine your personal information, like your location. To protect this information, Safari can hide your IP address from known trackers. [Learn more...](#)")
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        HideAddressView()
    }
}
