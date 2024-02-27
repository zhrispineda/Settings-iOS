//
//  AdvancedTrackingFingerprintingProtectionView.swift
//  Preferences
//
//  Settings > Safari > Advanced > Advanced Tracking and Fingerprinting Protection
//

import SwiftUI

struct AdvancedTrackingFingerprintingProtectionView: View {
    // Variables
    @State private var selected = "Private Browsing"
    let options = ["Off", "Private Browsing", "All Browsing"]
    
    var body: some View {
        CustomList(title: "Advanced Tracking and Fingerprinting Protection") {
            ForEach(options, id: \.self) { option in
                Button(action: { selected = option }, label: {
                    HStack {
                        Text(option)
                            .foregroundStyle(Color["Label"])
                        Spacer()
                        if selected == option {
                            Image(systemName: "checkmark")
                                .fontWeight(.medium)
                        }
                    }
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        AdvancedTrackingFingerprintingProtectionView()
    }
}
