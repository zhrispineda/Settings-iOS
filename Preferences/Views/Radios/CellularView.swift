//
//  CellularView.swift
//  Preferences
//
//  Settings > Cellular
//

import SwiftUI

struct CellularView: View {
    // Variables
    @State private var cellularDataEnabled = true
    @State private var mode: Int = 0
    @State private var wifiAssistEnabled = true
    @State private var cellularUsageStatisticsEnabled = true
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = UIDevice.iPhone ? "CellulariPhone" : "CellulariPad"
    
    var body: some View {
        CustomList {
            Placard(title: "Cellular", color: .green, icon: "antenna.radiowaves.left.and.right", description: "CELLULAR_SETTINGS_SUBTITLE".localize(table: table), frameY: $frameY, opacity: $opacity)
            
            Section {
                Button("SETUP_CELLULAR".localize(table: table)) {}
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("**Cellular**")
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
