//
//  PartsServiceHistoryView.swift
//  Preferences
//
//  Settings > General > About > Parts & Service History
//

import SwiftUI

struct PartsServiceHistoryView: View {
    // Variables
    @State private var opacity: Double = 0
    @State private var frameY: Double = 0
    let table = "CoreRepairKit"
    
    var body: some View {
        CustomList(title: "PARTS_AND_SERVICE".localize(table: table)) {
            // MARK: Placard
            Section {
                Placard(title: "PARTS_AND_SERVICE".localize(table: table), icon: "screwdriver.fill", description: UIDevice.iPad ? "PARTS_SERVICE_SUBTEXT_IPAD".localize(table: table) : "PARTS_SERVICE_SUBTEXT".localize(table: table), frameY: $frameY, opacity: $opacity)
            }
            
            // MARK: Service History Section
            Section("SERVICE_HISTORY".localize(table: table)) {
                //CustomNavigationLink("Face ID", status: "Issue") {}
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("PARTS_AND_SERVICE".localize(table: table))
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .opacity(frameY < 50.0 ? opacity : 0) // Only fade when passing the help section title at the top
            }
        }
    }
}

#Preview {
    NavigationStack {
        PartsServiceHistoryView()
    }
}
