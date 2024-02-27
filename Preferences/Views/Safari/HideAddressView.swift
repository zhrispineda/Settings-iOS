//
//  HideAddressView.swift
//  Preferences
//
//  Settings > Safari > Hide IP Address
//

import SwiftUI

struct HideAddressView: View {
    // Variables
    @State private var selectedOption = "Off"
    let options = ["From Trackers", "Off"]
    
    var body: some View {
        CustomList(title: "Hide IP Address") {
            Section(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: { selectedOption = option }, label: {
                        HStack {
                            Text(option)
                                .foregroundStyle(Color["Label"])
                            Spacer()
                            if selectedOption == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    })
                }
            }, footer: {
                Text("Your IP address can be used to determine your personal information, like your location. To protect this information, Safari can hide your IP address from known trackers. [Learn more...](#)")
            })
        }
    }
    
}

#Preview {
    NavigationStack {
        HideAddressView()
    }
}
