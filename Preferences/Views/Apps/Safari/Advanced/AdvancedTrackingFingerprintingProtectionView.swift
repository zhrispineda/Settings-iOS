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
            Picker("", selection: $selected) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        AdvancedTrackingFingerprintingProtectionView()
    }
}
