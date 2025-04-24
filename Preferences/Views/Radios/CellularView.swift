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
    @State private var mode = 0
    @State private var wifiAssistEnabled = true
    @State private var cellularUsageStatisticsEnabled = true
    @State private var frameY = 0.0
    @State private var opacity = 0.0
    @State private var showingHelpSheet = false
    let table = UIDevice.iPhone ? "CellulariPhone" : "CellulariPad"
    
    var body: some View {
        CustomList {
            Placard(title: "Cellular", color: .green, icon: "antenna.radiowaves.left.and.right", description: NSLocalizedString("CELLULAR_SETTINGS_SUBTITLE", tableName: table, comment: "").replacing("helpkit", with: "pref"), frameY: $frameY, opacity: $opacity)
            
            Section {
                Button("SETUP_CELLULAR".localize(table: table)) {}
            }
        }
        .onOpenURL {_ in
            showingHelpSheet.toggle()
        }
        .sheet(isPresented: $showingHelpSheet) {
            HelpKitView(topicID: UIDevice.iPhone ? "iph3dd5f213" : "ipadbfe780eb")
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Cellular")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .opacity(frameY < 50.0 ? opacity : 0)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CellularView()
    }
}
